# =====[ ENV CHECK ]======
# If not running interactively: exit immediately.
# Note that 'return' works because the file is sourced, not executed.

if [[ $- != *i* ]] || [ -z "$PS1" ]; then
  return 0
fi

source ~/.bashrc


# =====[ LOAD INCLUDES ]======

# load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.bash/*; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file



# enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar cmdhist extglob cdable_vars; do
  shopt -s "$option" 2> /dev/null
done
unset option

# When the command contains an invalid history operation (for instance when
# messages) or a failed substitution (e.g. "^foo^bar" when there was no "foo"
# using an unescaped "!" (I get that a lot in quick e-mails and commit
# in the previous command line), do not throw away the command line, but let me
# correct it.
shopt -s histreedit;

# append to the Bash history file, rather than overwriting it
shopt -s histappend

# rezize the windows-size if needed
shopt -s checkwinsize

# multiline history

shopt -s cmdhist
# check if the user isn't root
if [ "$UID" != 0 ]; then

  # case-insensitive globbing (used in pathname expansion)
  shopt -s nocaseglob

  # autocorrect typos in path names when using `cd`
  shopt -s cdspell
fi

# Do not autocomplete when accidentally pressing Tab on an empty line. (It takes
# forever and yields "Display all 15 gazillion possibilites?")
shopt -s no_empty_cmd_completion;

HISTCONTROL=erasedups:ignoreboth
HISTSIZE=1000000
HISTFILESIZE=1000000
HISTIGNORE="&:ls:[bf]g:history:exit"  #ignore these commands from history




export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
. "$HOME/.cargo/env"

# opam configuration
test -r /home/t3nj1n/.opam/opam-init/init.sh && . /home/t3nj1n/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
