#!/usr/bin/env bash

add_source() {
    DESTINATION=$1
    SOURCE_COMMAND=$2

    touch ${DESTINATION}

    if [[ $(grep -c "${SOURCE_COMMAND}" ${DESTINATION}) -eq 0 ]]; then
        # destination file does not contain source command, prepend it
        echo -e "${SOURCE_COMMAND}\n\n$(cat ${DESTINATION})" > ${DESTINATION}
    fi

    echo "${SOURCE_COMMAND} > ${DESTINATION}"
}

CONFIG_ROOT=`(cd $(dirname $0) && pwd)` # path to dotfiles root

# packages
echo "Installing packages..."
if [ "$(uname)" == "Darwin" ]; then
    # install with homebrew
	echo "Installing with homebrew"
	brew update
	brew install git openssh tmux vim neovim tmux-mem-cpu-load
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	if [ $OSTYPE == "linux-android" ]; then
		# install with pkg
		echo "Installing with pkg"
		pkg upgrade
		pkg install proot git openssh tmux vim neovim
		termux-chroot
	else
		# install with apt
		echo "Installing with apt"
		sudo apt update
		sudo apt install git openssh tmux vim neovim tmux-mem-cpu-load
	fi
else
	echo "Cannot install packages, unsupported OS: $(uname)"
fi

# bash
echo -e "\nConfiguring bash..."
add_source ~/.bashrc "source ${CONFIG_ROOT}/.bashrc"
source ~/.bashrc

# git
echo -e "\nConfiguring git..."
curl -fLso .git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
add_source ~/.bashrc "source ${CONFIG_ROOT}/.git-prompt.sh"

curl -fLso .git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
add_source ~/.bashrc "source ${CONFIG_ROOT}/.git-completion.sh"

# tmux
echo -e "\nConfiguring tmux..."
add_source ~/.tmux.conf "source-file ${CONFIG_ROOT}/.tmux.conf"
mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# vim
echo -e "\nConfiguring vim..."
add_source ~/.vimrc ":source ${CONFIG_ROOT}/.vimrc"
curl -fLso ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
echo "vim.plug installed"

# config files
echo -e "\nLinking config files..."
ln -sf ${CONFIG_ROOT}/.alacritty.yml ~/.alacritty.yml

# termux
# todo check $OSTYPE for termux-android
# symlink .termux folder
# termux-setup-storage


echo -e "\nDone!"
