#!/bin/bash -e
# Install some dependencies for this configuration works

# Determine OS platform
# Ref: https://unix.stackexchange.com/questions/92199/how-can-i-reliably-get-the-operating-systems-name/92218#92218
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
        # Otherwise, use release info file
    elif [ -f /etc/redhat-release ]; then
        export DISTRO="redhat"
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME

echo "OS detected as: $DISTRO"

if [ "$DISTRO" == "Ubuntu" ]; then
    # install gtags
    # Ref: https://askubuntu.com/questions/839852/emacs-c-ide-gnu-global-helm-gtags
    sudo apt install global
    # install clang-format
    sudo apt install clang-format
    # install ag (sliver search)
    sudo apt install silversearcher-ag
    # install yamllint
    sudo apt install yamllint
    # install pylint
    pip3 install pylint
elif [ "$DISTRO" == "darwin" ]; then
    brew install global
    brew install the_silver_searcher
    pip3 install pylint
    brew install ripgrep
    brew install gzip
elif [ "$DISTRO" == "redhat" ]; then
    sudo yum -y install global clang-format yamllint pylint
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum -y install ripgrep
fi


# install rust-related
curl https://sh.rustup.rs -sSf | sh
rustup toolchain add nightly
rustup component add rust-src
cargo +nightly install racer
rustup component add rustfmt

# install go-related (assume go is pre-installed)
if [ `which go` != "" ]; then
    go get github.com/rogpeppe/godef
    go get golang.org/x/tools/cmd/guru
fi
