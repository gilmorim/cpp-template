#!/usr/bin/env bash

USER=ubuntu
PROJ=cppdev

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

# So that bins are available on every new terminal
echo -e '\nexport WORKON_HOME=~/.venvs' >> /home/$USER/.bashrc
echo -e '\nexport PATH="/usr/share/virtualenvwrapper:$PATH"' >> /home/$USER/.bashrc
echo -e '\nsource /usr/share/virtualenvwrapper/virtualenvwrapper.sh' >> /home/$USER/.bashrc

export PATH=/usr/share/virtualenvwrapper:/home/$USER/.local/bin:$PATH
export WORKON_HOME=~/.venvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

mkdir -p $WORKON_HOME

mkvirtualenv $PROJ
