# Only run on macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
  # needed for brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Only run these on Ubuntu and Fedora

if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -Eqi "ubuntu|fedora|pop")$? == 0 ]]; then
  # needed for brew to work
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

export XDG_CONFIG_HOME="$HOME"/.config

# python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/brad/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
