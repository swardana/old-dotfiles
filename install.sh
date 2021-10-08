#!/usr/bin/env bash
#
{ # This ensures the entire script is downloaded.

set -eo pipefail

BASEDIR="$HOME/.dotfiles"
BINDIR="$HOME/bin"
REPOURL="git://github.com/swardana/dotfiles.git"

function symlink() {
  src="$1"
  dest="$2"

  if [ -e "$dest" ]; then
    if [ -L "$dest" ]; then
      if [ ! -e "$dest" ]; then
        echo "Removing broken symlink at $dest"
        rm "$dest"
      else
        # Already symlinked -- I'll assume correctly.
        return 0
      fi
    else
      # Rename files with a ".old" extension.
      echo "$dest already exists, renaming to $dest.old"
      backup="$dest.old"
      if [ -e "$backup" ]; then
        echo "Error: "$backup" already exists. Please delete or rename it."
        exit 1
      fi
      mv "$dest" "$backup"
    fi
  fi
  ln -sf "$src" "$dest"
}

if ! which git >/dev/null ; then
  echo "Error: git is not installed"
  exit 1
fi

if [ -d "$BASEDIR/.git" ]; then
  echo "Updating dotfiles using existing git..."
  cd "$BASEDIR"
  git pull --quiet --rebase origin master || exit 1
else
  echo "Checking out dotfiles using git..."
  rm -rf "$BASEDIR"
  git clone --quiet --depth=1 "$REPOURL" "$BASEDIR"
fi

cd "$BASEDIR"

echo "Updating common Zsh completions..."
rm -rf .zsh-completions ~/.zcompdump
git clone --quiet --depth=1 https://github.com/zsh-users/zsh-completions .zsh-completions

echo "Creating shell runtime configuration symlinks..."
symlink "$BASEDIR/shellrc/bash_profile" "$HOME/.bash_profile"
symlink "$BASEDIR/shellrc/bashrc" "$HOME/.bashrc"
symlink "$BASEDIR/shellrc/zlogin" "$HOME/.zlogin"
symlink "$BASEDIR/shellrc/zshrc" "$HOME/.zshrc"

echo "Creating vim runtime configuration symlinks..."
symlink "$BASEDIR/vim/vimrc" "$HOME/.vimrc"
symlink "$BASEDIR/vim/gvimrc" "$HOME/.gvimrc"

echo "Adding executables to ~/bin/..."
mkdir -p "$BINDIR"
for item in bin/* ; do
  symlink "$BASEDIR/$item" "$BINDIR/$(basename $item)"
done

echo "Setting up git..."
cp "$BASEDIR/git/gitconfig.base" "$HOME/.gitconfig"

if which git-lfs >/dev/null 2>&1 ; then
  git lfs install
fi

postinstall="$HOME/.postinstall"
if [ -e "$postinstall" ]; then
  echo "Running post-install..."
  source "$postinstall"
else
  echo "No post install script found. Optionally create one at $postinstall"
fi

echo "Done."
echo "Ensure to perform source ~/.bashrc or source ~/.zshrc."

} # This ensures the entire script is downloaded.
