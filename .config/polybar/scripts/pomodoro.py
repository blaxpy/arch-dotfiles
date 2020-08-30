#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import operator
import os
import select
import socket
import subprocess
import sys
import time
from contextlib import contextmanager
from enum import Enum
from typing import Iterator, Union

DEFAULT_WORK_TIME = 30 * 60
DEFAULT_BREAK_TIME = 5 * 60
SOUND_FILE = os.path.join(os.path.dirname(__file__), "sound.mp3")

SOCK_DIR = os.environ.get("XDG_RUNTIME_DIR", "/var/tmp")
SOCK_FILE = os.path.join(SOCK_DIR, "pomodoro.sock")


class Mode(str, Enum):
    WORK = "󱎫"
    BREAK = "󰔛"


class Actions(str, Enum):
    TOGGLE = "toggle"
    END = "end"
    LOCK = "lock"
    TIMER = "timer"


class ChangeOperator(str, Enum):
    ADD = "add"
    SUB = "sub"


class Timer:
    def __init__(self, seconds: int):
        self.seconds = seconds
        self.previous_time = time.time()
        self.notified = False

    def change(self, op: Union[operator.add, operator.sub], seconds: int):
        self.seconds = op(self.seconds, seconds)

    def update(self):
        now = time.time()
        delta = now - self.previous_time
        self.seconds -= delta

        if self.seconds < 0:
            # Send a notification when the timer reaches zero.
            if not self.notified and self.seconds < 0:
                self.notified = True
                subprocess.Popen(["notify-send", "--urgency=critical", "Pomodoro", "Timer reached zero"])
                subprocess.Popen(["mpv", "--really-quiet", SOUND_FILE])
        else:
            # Resend the notification if a user has increased the time after the timer expiration.
            if self.notified:
                self.notified = False

    def tick(self):
        self.previous_time = time.time()

    def __str__(self):
        if self.seconds > 0:
            seconds = self.seconds
            sign = ""
        else:
            seconds = -self.seconds
            sign = "-"

        seconds = int(seconds)

        minutes, seconds = divmod(seconds, 60)
        hours, minutes = divmod(minutes, 60)
        days, hours = divmod(hours, 24)

        parts = []
        if days:
            parts.append(str(days))
        if hours:
            parts.append(f"{hours:02}")
        parts.append(f"{minutes:02}")
        parts.append(f"{seconds:02}")

        return f"{sign}{':'.join(parts)}"


class Status:
    def __init__(self, work_time: int, break_time: int):
        self.work_time = work_time
        self.break_time = break_time

        self.mode = Mode.WORK
        self.active = False
        self.locked = True

        self._timer = Timer(self.work_time)

    def show(self):
        sys.stdout.write(f"{self.mode}{self._timer}\n")
        sys.stdout.flush()

    def toggle(self):
        self.active = not self.active

    def lock(self):
        self.locked = not self.locked

    def end(self):
        self.active = False

        if self.mode == Mode.WORK:
            self.mode = Mode.BREAK
            self._timer = Timer(self.break_time)
        elif self.mode == Mode.BREAK:
            self.mode = Mode.WORK
            self._timer = Timer(self.work_time)

    def timer(self, op: str, seconds: str):
        if self.locked:
            return

        seconds = int(seconds)
        op = operator.add if op == ChangeOperator.ADD else operator.sub

        self._timer.change(op, seconds)

    def tick(self):
        if self.active:
            self._timer.update()
        self._timer.tick()


@contextmanager
def setup_listener() -> Iterator[socket.socket]:
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)

    try:
        os.remove(SOCK_FILE)
    except OSError:
        pass

    sock.bind(SOCK_FILE)

    try:
        yield sock
    finally:
        sock.close()
        try:
            os.remove(SOCK_FILE)
        except OSError:
            pass


@contextmanager
def setup_client() -> Iterator[socket.socket]:
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
    sock.connect(SOCK_FILE)

    try:
        yield sock
    finally:
        sock.close()


def send_message(message: str):
    with setup_client() as sock:
        data = message.encode("utf8")
        sock.send(data)


def check_actions(sock: socket.socket, status: Status):
    timeout_time = time.time() + 0.9

    data = ""
    while True:
        ready = select.select([sock], [], [], 0.2)
        if time.time() > timeout_time:
            break
        if ready[0]:
            try:
                data = sock.recv(1024)
                if data:
                    break
            except socket.error as e:
                print("Lost connection to client. Printing buffer...", e)
                break

    if not data:
        return

    message = data.decode("utf8")
    if message == Actions.TOGGLE:
        status.toggle()
    elif message == Actions.END:
        status.end()
    elif message == Actions.LOCK:
        status.lock()
    elif message.startswith(Actions.TIMER):
        _, op, seconds = message.split(" ")
        status.timer(op, seconds)


def action_show(args):
    status = Status(args.work_time, args.break_time)

    with setup_listener() as sock:
        while True:
            status.show()
            status.tick()
            check_actions(sock, status)


def action_toggle(args):
    send_message(Actions.TOGGLE.value)


def action_end(args):
    send_message(Actions.END.value)


def action_lock(args):
    send_message(Actions.LOCK.value)


def action_timer(args):
    op, seconds = args.delta
    message = f"{Actions.TIMER} {op} {seconds}"
    send_message(message)


class ValidateDelta(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        if values[0] not in "-+":
            parser.error("Time format should be +num or -num to add or remove time, respectively")

        if not values[1:].isdigit():
            parser.error(f"Expected number after +/- but saw '{values[1:]}'")

        op = ChangeOperator.ADD if values[0] == "+" else ChangeOperator.SUB
        seconds = values[1:]
        delta = (op, seconds)

        setattr(namespace, self.dest, delta)


def parse_args():
    parser = argparse.ArgumentParser(description="Pomodoro timer to be used with polybar")

    parser.add_argument("--work-time", type=int, default=DEFAULT_WORK_TIME, help="Default work time (in seconds)")
    parser.add_argument("--break-time", type=int, default=DEFAULT_BREAK_TIME, help="Default break time (in seconds)")
    parser.set_defaults(func=action_show)

    subparsers = parser.add_subparsers()

    toggle = subparsers.add_parser(Actions.TOGGLE, help="start/stop the current timer")
    toggle.set_defaults(func=action_toggle)

    end = subparsers.add_parser(Actions.END, help="end the current timer")
    end.set_defaults(func=action_end)

    lock = subparsers.add_parser(Actions.LOCK, help="lock time change actions")
    lock.set_defaults(func=action_lock)

    timer = subparsers.add_parser(Actions.TIMER, help="change time of the current timer")
    timer.add_argument("delta", action=ValidateDelta, help="Time to add/remove to the current timer (in seconds)")
    timer.set_defaults(func=action_timer)

    return parser.parse_args()


def main():
    args = parse_args()
    args.func(args)


if __name__ == "__main__":
    main()

# vim: ai sts=4 et sw=4
