" Yank from cursor to end of line like 'C' and 'D'
nnoremap Y y$

" Clear the highlighting of search matches
nnoremap <c-l> :nohlsearch<cr>

" Top row
nnoremap <leader>q :action QuickJavaDoc<cr>
nnoremap <leader>w :action RecentChangedFiles<cr>
nnoremap <leader>e :action RecentFiles<cr>
nnoremap <leader>E :action RecentLocations<cr>
nnoremap <leader>t :action GotoTest<cr>
nnoremap <leader>T :action GotoRelated<cr>
nnoremap <leader>y :action ShowUmlDiagramPopup<cr>
nnoremap <leader>Y :action ShowUmlDiagram<cr>
nnoremap <leader>u :action ShowUsages<cr>
nnoremap <leader>U :action FindUsages<cr>
nnoremap <leader>i :action GotoImplementation<cr>
nnoremap <leader>I :action QuickImplementations<cr>
nnoremap <leader>o :action GotoSuperMethod<cr>
nnoremap <leader>p :action FindInPath<cr>
nnoremap <leader>p :action FindInPath<cr>
vnoremap <leader>p :action FindInPath<cr>
nnoremap <leader>P :action ReplaceInPath<cr>
vnoremap <leader>P :action ReplaceInPath<cr>

nnoremap <leader>i :action OptimizeImports<cr>
nnoremap <leader>o :action Tool_External Tools_Black<cr>
nnoremap <leader>O :action ReformatCode<cr>
vnoremap <leader>O :action ReformatCode<cr>

nnoremap \w :action SurroundWith<cr>
vnoremap \w :action SurroundWith<cr>
nnoremap \r :action Run<cr>
nnoremap \R :action ChooseRunConfiguration<cr>
nnoremap \c :action CMake.BuildMenu<cr>
nnoremap \t :action Refactorings.QuickListPopupAction<cr>

" Middle row
nnoremap <leader>a :action GotoAction<cr>
nnoremap <leader>s :action GotoSymbol<cr>
vnoremap <leader>s :action GotoSymbol<cr>
nnoremap <leader>f :action GotoFile<cr>
vnoremap <leader>f :action GotoFile<cr>
nnoremap <leader>g :action Annotate<cr>
nnoremap <leader>k :action CallHierarchy<cr>
nnoremap <leader>h :action TypeHierarchy<cr>
nnoremap <leader>j :action ActivateStructureToolWindow<cr>
nnoremap <leader>J :action FileStructurePopup<cr>

nnoremap \s :action Stop<cr>
nnoremap \d :action Debug<cr>
nnoremap \D :action ChooseDebugConfiguration<cr>
nnoremap \g :action Vcs.QuickListPopupAction<cr>

" Bottom row
nnoremap <leader>z :action CopyPaths<cr>
nnoremap <leader>x :action CopyReference<cr>
nnoremap <leader>c :action GotoClass<cr>
vnoremap <leader>c :action GotoClass<cr>
nnoremap <leader>n :action ActivateProjectToolWindow<cr>
nnoremap <leader>m :action ShowNavBar<cr>
nnoremap <leader>/ :action Find<cr>
vnoremap <leader>/ :action Find<cr>
nnoremap <leader>? :action Replace<cr>
vnoremap <leader>? :action Replace<cr>

nnoremap \b :action ToggleLineBreakpoint<cr>
nnoremap \B :action ViewBreakpoints<cr>

" Unimpaired
nnoremap [<space> O<esc>j
nnoremap ]<space> o<esc>k
nnoremap [e :action MoveLineUp<cr>
nnoremap ]e :action MoveLineDown<cr>
nnoremap [r :action MoveStatementUp<cr>
nnoremap ]r :action MoveStatementDown<cr>
nnoremap [c :action VcsShowPrevChangeMarker<cr>
nnoremap ]c :action VcsShowNextChangeMarker<cr>
nnoremap ]l :action GotoNextError<cr>
nnoremap [l :action GotoPreviousError<cr>
vnoremap [u :action osmedile.intellij.stringmanip.URLEncodeAction<cr>
vnoremap ]u :action osmedile.intellij.stringmanip.URLDecodeAction<cr>
