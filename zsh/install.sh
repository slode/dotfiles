#####################################
# Install basic zsh settings
#####################################
cp -v `pwd`/zshrc.symlink ~/.zshrc
cp -rvuT `pwd`/zsh.symlink ~/.zsh


git clone https://github.com/slode/zsh-fmt-command-line.git ~/.zsh/longlines
