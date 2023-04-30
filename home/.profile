#!/bin/bash

# Add GHC 7.8.4 to the PATH, via http://ghcformacosx.github.io/
export GHC_DOT_APP="/Users/ershov/Applications/ghc-7.8.4.app"
if [ -d "$GHC_DOT_APP" ]; then
    export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

#alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g -f'
#alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g -f'
alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

alias env-ports='. ~/src/build/macports/env.sh'
alias env-ports-py3='. ~/src/build/macports/py3/env.sh'
alias env-ports-opencv='. ~/src/build/macports/opencv/env.sh ; cd ~/src/build/macports/opencv/src/'

# MacPorts Installer addition on 2016-01-20_at_16:38:15: adding an appropriate PATH variable for use with MacPorts.
#done in /etc/paths # export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PERLBREW_ROOT="$HOME/bin/perlbrew"
export PERLBREW_HOME="$PERLBREW_ROOT/.perlbrew"
export PATH="$HOME/bin:$PERLBREW_ROOT/bin:$HOME/bin/brew/bin:$PATH"

export HISTSIZE=100000
export HISTCONTROL=ignoreboth

source /usr/local/git/current/share/git-core/git-completion.bash

source $PERLBREW_ROOT/etc/bashrc

