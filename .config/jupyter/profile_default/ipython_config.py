import sys

from prompt_toolkit.key_binding.vi_state import InputMode, ViState


def get_input_mode(self):
    if sys.version_info[0] == 3:
        # Decrease input flush timeout from 500ms to 10ms.
        from prompt_toolkit.application.current import get_app

        app = get_app()
        app.ttimeoutlen = 0.01

    return self._input_mode


def set_input_mode(self, mode):
    shape = {InputMode.NAVIGATION: 2, InputMode.REPLACE: 4}.get(mode, 6)
    cursor = "\x1b[{} q".format(shape)

    if hasattr(sys.stdout, "_cli"):
        write = sys.stdout._cli.output.write_raw
    else:
        write = sys.stdout.write

    write(cursor)
    sys.stdout.flush()

    self._input_mode = mode


ViState._input_mode = InputMode.INSERT
ViState.input_mode = property(get_input_mode, set_input_mode)

# Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = False

# Automatically call the pdb debugger after every exception.
# c.InteractiveShell.pdb = False

# Options for displaying tab completions, 'column', 'multicolumn', and
# 'readlinelike'. These options are for `prompt_toolkit`, see `prompt_toolkit`
# documentation for more information.
# c.TerminalInteractiveShell.display_completions = 'multicolumn'

# Shortcut style to use at the prompt. 'vi' or 'emacs'.
c.TerminalInteractiveShell.editing_mode = "vi"
c.TerminalInteractiveShell.prompt_includes_vi_mode = False

# Set the editor used by IPython (default to $EDITOR/vi/notepad).
c.TerminalInteractiveShell.editor = "nvim"

# Enable vi (v) or Emacs (C-X C-E) shortcuts to open an external editor. This is
# in addition to the F2 binding, which is always enabled.
c.TerminalInteractiveShell.extra_open_editor_shortcuts = True
