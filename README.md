# My NEOVIM Configuration

I switched from VIM to NEOVIM for a reason I already forgot. Anyway, I found this config useful and sufficient for me, so I would like to share this. I have got most of the required files in this repo, but some prerequisites are still necessary. 

## Getting Started

I am currently using this config in Ubuntu18.04, so I'm not sure will it work on other OS, but most of the time it should be similar.

### Prerequisites

#### neovim

Here is a tricky part. For Ubuntu18.04, if we directly apt-get neovim, the most recent version is only 0.2, but we need at least 0.3.1 for the coc.vim plugin. Therefore, we need to install via PPA.

```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim
```

#### exuberant-ctags

For the purpose of navigating functions with ctags.

```
sudo apt-get install exuberant-ctags
```

#### nodejs

Dependency of coc.vim plugin.

```
curl -sL install-node.now.sh | sh
```

#### ack

Dependency of ack.vim plugin.

```
sudo apt-get install ack-grep
```

### Installing

```
cd ~/.config
git clone https://github.com/evamo0508/nvim.git
```

NEOVIM requires typing nvim to trigger, but we could do something to make our life easier, so that we could still type either vi or vim to trigger nvim.

```
# put those lines under ~/.bashrc
alias vi='nvim'
alias vim='nvim'
```

Or, the one I used:

```
sudo ln -s /usr/bin/nvim /usr/bin/vi
sudo ln -s /usr/bin/nvim /usr/bin/vim
```

To install the plugins within the init.vim under this repo (served as the same purpose of .vimrc in traditional VIM), we need to:

```
vi # enter NEOVIM
:PluginInstall # should appear at the very bottom of NEOVIM
```

Press ENTER and wait for a while to install every plugin.

## How To Use

I'm too lazy to document all this down right now. Stay tuned lol.
