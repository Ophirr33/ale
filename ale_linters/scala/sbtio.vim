" Author: ophirr33 <coghlan.ty@gmail.com>
" Description: Stdio wrapper of the sbt langauge server

call ale#Set('scala_sbtio_executable', 'sbtio')

function! ale_linters#scala#sbtio#GetCommand(buffer) abort
    " let l:active_file = ale#path#FindNearestFile(a:buffer, 'active.json')
    " let l:executable = ale#Var(a:buffer: 'scala_sbtio_executable')

    " return !empty(l:active_file) ? l:executable : ''
    return ale#Var(a:buffer, 'scala_sbtio_executable')
endfunction

function! ale_linters#scala#sbtio#GetProjectRoot(buffer) abort
    let l:project_root = ale#path#FindNearestFile(a:buffer, 'build.sbt')
    return !empty(l:project_root) ? fnamemodify(l:project_root, ':h') : ''
endfunction

call ale#linter#Define('scala', {
\   'name': 'sbtio',
\   'lsp': 'stdio',
\   'executable_callback': ale#VarFunc('scala_sbtio_executable'),
\   'command_callback': 'ale_linters#scala#sbtio#GetCommand',
\   'project_root_callback': 'ale_linters#scala#sbtio#GetProjectRoot',
\})
