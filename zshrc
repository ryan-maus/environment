####################
### Dependencies ### (cloned here, some requre manual installation)
####################

DEPENDENCY_DIR=$HOME/source/thirdparty/

# ZPlug
ZPLUG_DIR=$DEPENDENCY_DIR/zplug
if [ ! -d $ZPLUG_DIR ]; then
    printf "Clone zplug [y/N]: "
    if read -q; then
        echo;
        cd $DEPENDENCY_DIR
	git clone "https://github.com/zplug/zplug.git"
	cd -
    fi
fi
source $ZPLUG_DIR/init.zsh

# Solarized Gnome Terminal
SOLARIZED_GNOME_TERMINAL_DIR=$DEPENDENCY_DIR/gnome-terminal-colors-solarized
if [ ! -d $SOLARIZED_GNOME_TERMINAL_DIR ]; then
    printf "Clone gnome-terminal-colors-solarized? [y/N]: "
    if read -q; then
        echo;
	cd $DEPENDENCY_DIR
	git clone "https://github.com/Anthony25/gnome-terminal-colors-solarized.git"
	echo "This dependency needs to be installed manually!"
	cd -
    fi
fi

# Solarized Directory Colors
SOLARIZED_DIRCOLORS_DIR=$DEPENDENCY_DIR/dircolors-solarized
if [ ! -d $SOLARIZED_DIRCOLORS_DIR ]; then
    printf "Clone dircolors-solarized? [y/N]: "
    if read -q; then
        echo;
	cd $DEPENDENCY_DIR
	git clone "https://github.com/seebi/dircolors-solarized.git"
	cd -
    fi
fi
eval `dircolors $SOLARIZED_DIRCOLORS_DIR/dircolors.256dark`

# Terminal Fonts
TERMINAL_FONTS_DIR=$DEPENDENCY_DIR/awesome-terminal-fonts
if [ ! -d $TERMINAL_FONTS_DIR ]; then
    printf "Clone awesome-terminal-fonts? [y/N]: "
    if read -q; then
        echo;
        cd $DEPENDENCY_DIR
	git clone "https://github.com/gabrielelana/awesome-terminal-fonts.git"
	echo "This dependency needs to be installed manually!"
	cd -
    fi
fi
source $TERMINAL_FONTS_DIR/build/fontawesome-regular.sh
source $TERMINAL_FONTS_DIR/build/octicons-regular.sh


##############
### Colors ###
##############

export TERM="xterm-256color"
autoload -U colors && colors


###############
### Exports ###
###############

export EDITOR=emacs
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH


#########################
### ZSH Configuration ###
#########################

HISTSIZE=10000000                    # size of in-memory terminal history
SAVEHIST=10000000                    # size of history file
HISTFILE=$HOME/.zsh_history          # save history to this file

setopt AUTO_MENU                     # always use menu completion for second consecutive completion request (<TAB>)
setopt AUTO_LIST                     # always list choices on ambiguous completion
setopt AUTO_CD                       # entering invalid command that matches a dir will cd there
setopt AUTO_PUSHD                    # automatically push directories onto the directory stack when using 'cd' (use 'dirs -v' to see stack)
setopt PUSHD_MINUS                   # swaps "cd +N" and "cd -N", which makes more sense
setopt PUSHD_TO_HOME                 # push ~ onto directory stack when no arguments are given to 'pushd'
setopt PUSHD_SILENT                  # 'pushd' command operates silently
setopt PUSHD_IGNORE_DUPS             # do not store duplicate entries in the directory stack
setopt CORRECT_ALL                   # prompt for typing corrections for all arguments in a line
setopt HIST_IGNORE_DUPS              # Don't record an entry if new entry is a duplicate
setopt HIST_IGNORE_ALL_DUPS          # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS             # when searching history, don't display results already cycled through
setopt HIST_REDUCE_BLANKS            # trims whitespace from commands before being stored in history
setopt INC_APPEND_HISTORY            # append history to file incrementally (instead of on shell exit)
setopt SHARE_HISTORY                 # share history between all sessions
setopt HIST_SAVE_NO_DUPS             # don't write duplicate entries to the history file
setopt EXTENDED_HISTORY              # adds timestamps to history file
setopt EXTENDED_GLOB                 # treat '#', '~' and '^' in filename patterns
setopt NO_HUP                        # automatically nohup all commands
setopt NO_CHECK_JOBS                 # don't block terminal exit with running jobs (they've been nohupped anyways)
setopt GLOB_COMPLETE                 # completion for globbed words opens a menu instead of inserting all matches into command
setopt COMPLETE_ALIASES              # don't expand aliases before completion has finished
setopt COMPLETE_IN_WORD              # allow completion from within a word
setopt ALWAYS_TO_END                 # when completing from middle of word, move cursor to the end
setopt NONOMATCH                     # pass unmatched globs to command instead of printing an error

unsetopt MENU_COMPLETE               # Do not autoselect the first completion entry.
unsetopt CLOBBER                     # Do not allow > and >> to overwrite files (use >! and >>! instead)

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'   # excludes '/' so we can delete single directories from path arguments


#######################
### ZSH Completions ###
#######################

# style completions, format is as follows:
# :completion:function:completer:command:argument:tag

# list of completers to use
zstyle ':completion:*::::' completer _complete _ignored _approximate

# enable caching to make completions more usable for commands with lots of them
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcache"

# format for completion menu groups
zstyle ':completion:*' format ' %B%d'

# automatically search for new completions on $PATH
zstyle ':completion:*' rehash true

# place most recently touched files first in completion menu
zstyle ':completion:*' file-sort modification

# enable highlighted menu for completion lists
zstyle ':completion:*:*:*:*:*' menu select

# enable colored completion lists
zstyle ':completion:*' list-colors ''

# separate completions by type
zstyle ':completion:*' group-name ''

# show descriptions for command options if available
zstyle ':completion:*' verbose yes

# case insensitive completions
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# hypen/dash insensitive completions
zstyle ':completion:*' matcher-list '' 'm:{-_}={_-}'

# make list prompt more friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# enable paging for large completion lists
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# enable PID completions and custom styling for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,tty,start,time,command"

# use LS_COLORS to color completion menu
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# format completion descriptions
zstyle ':completion:*:descriptions' format '%B%d%b'

# format completion messages
zstyle ':completion:*:messages' format '%d'

# format completion warnings
zstyle ':completion:*:warnings' format 'No matches for: %d'

# format corrections (_approximate completer)
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b' # used by _approximate completer to format corrections

# allow 1 error per 3 characters typed (_approximate completer)
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# ignore completion functions until _ignored completer
zstyle ':completion:*:functions' ignored-patterns '_*'

# user/host/IP completions
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//,/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users unless we really want to
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
zstyle '*' single-ignored show


###############
### Plugins ###
###############

# Fill out buffer with likely command as you type (C-e to accept) (TODO: currently broken if we use xterm-256 color for some reason)
#zplug "zsh-users/zsh-autosuggestions"

# Extra completions for a wide variety of applications (cmake, ansible, etc)
zplug "zsh-users/zsh-completions"

# Automatic terminal window titles
zplug "jreese/zsh-titles"

# Provide a single argless command for expanding zip, tar, etc
zplug "plugins/extract", from:oh-my-zsh

# Apply syntax highlighting to man pages
zplug "zuxfoucault/colored-man-pages_mod"

# Fuzzy search history with current input, opens menu (ctrl-r)
zplug "zdharma/history-search-multi-word"
	zstyle ":history-search-multi-word" page-size "$LINES" # Number of entries to show (default is $LINES/3)

# Provide keybindings to quickly navigate directory stack
zplug "plugins/dirhistory", from:oh-my-zsh
	bindkey -M emacs '^[p' dirhistory_zle_dirhistory_back    # quick cd to previous directory
	bindkey -M emacs '^[n' dirhistory_zle_dirhistory_future  # quick cd to next directory

# Store history on a per-directory basis, as well as global.  Toggle with (ctrl-h)
zplug "jimhester/per-directory-history"
	HISTORY_BASE=$HOME/.zsh_history_by_dir  # storage location for per-directory history
	PER_DIRECTORY_HISTORY_TOGGLE='^H'       # keybind for toggling per-directory history

# Apply syntax highlighting as you type
zplug "zsh-users/zsh-syntax-highlighting", defer:2   # defer:2 runs after compinit
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root line)
	typeset -A ZSH_HIGHLIGHT_STYLES
	ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
	ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=white,bold'
	ZSH_HIGHLIGHT_STYLES[redirection]='fg=white,bold'
	ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan,bold'
	ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan,bold'

# Exact history search with current input, replaces input (ctrl-n and ctrl-p to cycle)
zplug "zsh-users/zsh-history-substring-search", defer:3 # defer:3 runs after zsh-syntax-highlighting
	bindkey -M emacs '^P' history-substring-search-up    # search history with text currently on command line
	bindkey -M emacs '^N' history-substring-search-down  # search history with text currently on command line


#############
### Theme ###
#############

UNICODE_BOX_DRAWINGS_LIGHT_ARC_UP_AND_RIGHT="\u2570"
UNICODE_BOX_DRAWINGS_LIGHT_ARC_DOWN_AND_RIGHT="\u256D"
UNICODE_BOX_DRAWINGS_LIGHT_HORIZONTAL="\u2500"

zplug "bhilburn/powerlevel9k", as:theme
	POWERLEVEL9K_MODE='awesome-fontconfig'
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir ssh)
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status background_jobs custom_per_dir_history_status)
	POWERLEVEL9K_COLOR_SCHEME='light'
	POWERLEVEL9K_PROMPT_ON_NEWLINE=true
	POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
	POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="$UNICODE_BOX_DRAWINGS_LIGHT_ARC_DOWN_AND_RIGHT$UNICODE_BOX_DRAWINGS_LIGHT_HORIZONTAL"
	POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$UNICODE_BOX_DRAWINGS_LIGHT_ARC_UP_AND_RIGHT$UNICODE_BOX_DRAWINGS_LIGHT_HORIZONTAL$ "
	POWERLEVEL9K_SHOW_CHANGESET=true
	POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
	POWERLEVEL9K_TIME_FORMAT="%D{%Y/%m/%d \u$CODEPOINT_OF_AWESOME_CLOCK_O %H:%M:%S}"
	POWERLEVEL9K_TIME_BACKGROUND='cyan'
	POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
	POWERLEVEL9K_STATUS_OK_BACKGROUND='black'

	per_dir_history_status(){
	    if [[ $_per_directory_history_is_global == true ]]; then
		    echo "\u$CODEPOINT_OF_AWESOME_GLOBE"
	    else
		    echo "\u$CODEPOINT_OF_OCTICONS_FILE_SUBMODULE"
	    fi
	}
	POWERLEVEL9K_CUSTOM_PER_DIR_HISTORY_STATUS="per_dir_history_status"
	POWERLEVEL9K_CUSTOM_PER_DIR_HISTORY_STATUS_BACKGROUND="magenta"
	POWERLEVEL9K_CUSTOM_PER_DIR_HISTORY_STATUS_FOREGROUND="white"


#############
### ZPlug ###
#############
#
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load


##################
### Initialize ###
##################

_per-directory-history-set-global-history   # default for this plugin is per-directory history, set it back to global


###############
### Aliases ###
###############

alias g='git'
alias ls='ls --color=auto'                             # ls with color
alias ll="ls -lAh"                                     # long-list format
alias c="clear"                                        # clear screen
alias grep="grep --color=auto"                         # grep with color
alias egrep="egrep -n --color=auto"                       # egrep with color
alias less="less -R"                                   # less with color
alias egrepcpp="egrep -n -I --include=\*.{cc,cpp,h,inl}"  # egrep with only c++ source files
alias dirs='dirs -v'                                   # always show directory stack as a numbered list

# These bypass correction feature (CORRECT_ALL configuration above)
alias cd='nocorrect cd'           # do not correct args to 'cd' command
alias touch='nocorrect touch'     # do not correct args to 'touch' command
alias mv='nocorrect mv -i'        # do not correct args to 'mv' command; prompt before overwrite
alias cp='nocorrect cp -i'        # do not correct args to 'cp' command; prompt before overwrite
alias ln='nocorrect ln -i'        # do not correct args to 'ln' command; prompt before overwrite
alias rm='nocorrect rm'           # do not correct args to 'rm' command
alias man='nocorrect man'         # do not correct args to 'man' command
alias mkdir='nocorrect mkdir -p'  # do not correct args to 'mkdir' command; generate all dirs in path if necessary
alias sudo='nocorrect sudo'       # do not correct args to 'sudo' command


######################
### Global Aliases ### (apply anywhere in command line)
######################

alias -g G='| egrep'
alias -g WC='| wc -l'
alias -g TF='| tail -f'
alias -g DN='/dev/null'


#################
### Functions ###
#################

ssh-copy-id-if-needed()
{
    host=$1
    ssh -o PasswordAuthentication=no $host exit &>/dev/null
    if [[ $? -ne 0 ]]; then
        ssh-copy-id $host
    fi
}

