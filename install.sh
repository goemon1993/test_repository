#!/bin/bash

set -u

# 実行場所のディレクトリを取得
THIS_DIR=$(cd $(dirname $0); pwd)

cd $THIS_DIR
git submodule init
git submodule update

echo "start setup..."

for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    # [ "$f" = ".require_oh-my-zsh" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    ln -snfv /home/ec2-user/test_repository/"$f" ~/
done

[ -e /home/ec2-user/.gitconfig.local ] || cp /home/ec2-user/test_repository/.gitconfig.local.template ~/.gitconfig.local

# emacs set up
# if which cask >/dev/null 2>&1; then
#   echo "setup .emacs.d..."
#   cd ${THIS_DIR}/.emacs.d
#   cask upgrade
#   cask install
# fi

cd /home/ec2-user/test_repository/.zprezto/runcoms/

for f in *; do
    [ "$f" = "README.md" ] && continue

    ln -s "$f" /home/ec2-user/."$f"
done

cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END
