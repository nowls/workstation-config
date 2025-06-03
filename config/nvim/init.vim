" Pull in pared down Debian VIM defaults file
runtime! ./debian.vim

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set autowrite		" Automatically save before commands like :next and :make

" Spacing and tabs
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

let g:kernel_spacing_enabled = 0

" Toggle spacing for kernel development
lua << EOF
function _G.toggle_kernel_spacing()
  if vim.g.kernel_spacing_enabled == 0 then
    -- Switch to Linux kernel style
    vim.opt.tabstop = 8
    vim.opt.shiftwidth = 8
    vim.opt.softtabstop = 8
    vim.opt.expandtab = false
    vim.g.kernel_spacing_enabled = 1
    print("Linux kernel spacing enabled")
  else
    -- Switch to custom style
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true 
    vim.g.kernel_spacing_enabled = 0
    print("Custom spacing enabled")
  end
end
EOF

" Expose :ToggleKernelSpacing command
command! ToggleKernelSpacing lua _G.toggle_kernel_spacing()

" vim-plug
call plug#begin()
" Note: the github link maps to 'nvim-tree/nvim-web-devicons'
" Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neovim/nvim-lspconfig'
Plug 'sainnhe/sonokai'
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'stevearc/aerial.nvim'
Plug 'preservim/tagbar'
" This doesn't work on neovim v0.10.3:
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" lualine
lua require('lualine').setup()

" lspconfig
"lua require('lspconfig').pyright.setup{}
"lua require('lspconfig').clangd.setup{}

" aerial
lua << EOF
require("aerial").setup({
  -- layout
  layout = {
    max_width = { 120, 0.2 },
    min_width = 60,
    resize_to_content = true
  },
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
EOF

" vim-gutentags
let g:gutentags_enabled = 1
let g:gutentags_project_root = ['.git', '.hg', '.svn', '.project']
let g:gutentags_cache_dir = expand('~/.cache/nvim/tagfiles/')
if executable('uctags')
    let g:gutentags_ctags_executable = 'uctags'
else
    let g:gutentags_ctags_executable = 'ctags'
endif
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args = ['--exclude=.git', '--exclude=node_modules']
let g:gutentags_async = 1

" vista
let g:vista_default_executive = 'ctags'
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_icons = 'default'
let g:vista_sidebar_width = 60

" colorscheme
colorscheme molokayo
