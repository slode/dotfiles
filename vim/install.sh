#!/bin/bash

#####################################
# Install basic vim settings
#####################################

if [ -f ~/.vimrc ]; then
	echo "This will install a vim setup."
	echo "You already have a ~/.vimrc, and it will be"
	echo "overwritten."
	echo
	read -p "Press ENTER to continue, CTRL+C to abort."
fi

# Create vim directory if it does not exist
if [ ! -d ~/.vim ]; then
	mkdir -p ~/.vim/bundle
fi

# Use interactive copying
echo
echo Setting up ~/.vimrc
echo
cp -v `pwd`/vimrc ~/.vimrc

echo
echo Setting up ~/.vim
echo
cp -rvuT `pwd`/vim ~/.vim

echo
echo Setting up ~/.fonts
echo
cp -rv `pwd`/fonts ~/.fonts

#####################################
# Install all modules to .vim/bundle
#####################################

GIT=`which git`

PACKAGES="https://github.com/tpope/vim-pathogen.git
https://github.com/jceb/vim-orgmode.git
https://github.com/davidhalter/jedi-vim
https://github.com/kien/ctrlp.vim.git
https://github.com/nvie/vim-flake8.git
https://github.com/skwp/YankRing.vim.git
https://github.com/vim-scripts/Ada-Bundle.git
https://github.com/tpope/vim-git.git
https://github.com/gregsexton/gitv.git
https://github.com/tpope/vim-fugitive.git
https://github.com/pangloss/vim-javascript.git
https://github.com/ervandew/supertab.git
https://github.com/tomtom/tlib_vim.git
https://github.com/MarcWeber/vim-addon-mw-utils.git
https://github.com/garbas/vim-snipmate.git
https://github.com/honza/vim-snippets
https://github.com/skwp/vim-powerline.git
https://github.com/Rip-Rip/clang_complete.git
https://github.com/scrooloose/nerdtree.git
https://github.com/xuhdev/SingleCompile.git
https://github.com/vim-scripts/taglist.vim.git
https://github.com/jistr/vim-nerdtree-tabs.git
https://github.com/skwp/vim-colors-solarized.git
https://github.com/sjl/gundo.vim.git"

if [ -d ~/.vim/bundle ]; then
	cd ~/.vim/bundle
	for PACKAGE in $PACKAGES
 	do
		$GIT clone $PACKAGE
	done
fi
