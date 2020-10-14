Getting started
===============

If you're starting from scratch, go ahead and…
create a .cfg folder, which we'll use to track your dotfiles

```
git init --bare $HOME/.cfg
```

create an alias cfg so you don't need to type it all over again

```
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

set git status to hide untracked files

```
cfg config --local status.showUntrackedFiles no
```

add the alias to .bashrc (or .zshrc) so you can use it later

```
echo "alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
```

Usage
=====

Now you can use regular git commands such as:

```
cfg status
cfg add .vimrc
cfg commit -m "Add vimrc"
cfg add .bashrc
cfg commit -m "Add bashrc"
cfg push
```

Nice, right? Now if you're moving to a virgin system…

Setup environment in a new computer
===================================

Make sure to have git installed, then:

clone your github repository

```
git clone --bare https://github.com/USERNAME/cfg.git $HOME/.cfg
```

define the alias in the current shell scope

```
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

checkout the actual content from the git repository to your $HOME

```
cfg checkout main
```
