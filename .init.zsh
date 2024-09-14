#!/bin/zsh

git clone --bare https://github.com/morningdip/dotfiles.git $HOME/.dotfiles

# Define config alias locally since the dotfiles aren't installed on the system yet
function dots {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# Create a directory to backup existing dotfiles to
mkdir -p $HOME/.dotfiles-backup
dots checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:morningdip/dotfiles.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    dots checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $HOME/.dotfiles-backup/{}
fi

# Checkout dotfiles from repo
dots checkout
dots config status.showUntrackedFiles no
