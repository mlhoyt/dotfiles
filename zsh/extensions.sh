# Zsh extensions (effectively replaces OMZ)

######################################################################
# Prompt and Colors
######################################################################
autoload -U colors && colors
setopt prompt_subst

######################################################################
# History
######################################################################
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "${HISTSIZE:-0}" -lt 50000 ] && HISTSIZE=50000
[ "${SAVEHIST:-0}" -lt 10000 ] && SAVEHIST=10000

setopt extended_history       # record timestamp in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands in history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion before running
setopt share_history          # share history across shells

######################################################################
# Completion Framework and Styles (from OMZ completion.zsh)
######################################################################
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"
fpath=("$ZSH_CACHE_DIR/completions" $fpath)

autoload -Uz compinit
ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${HOST}-${ZSH_VERSION}"
compinit -d "$ZSH_COMPDUMP"

zmodload -i zsh/complist
WORDCHARS=''

unsetopt menu_complete flowcontrol
setopt auto_menu complete_in_word always_to_end

bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

if [[ "$OSTYPE" = solaris* ]]; then
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm"
else
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
fi

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR"
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'
zstyle '*' single-ignored show

autoload -U +X bashcompinit && bashcompinit

######################################################################
# Key Bindings (subset of OMZ key-bindings.zsh)
######################################################################
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() { echoti smkx; }
  function zle-line-finish() { echoti rmkx; }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# ESC+/ as history search (avoid completion expansion)
bindkey -M viins '^[/' history-incremental-search-backward

# History search with up/down
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey -M viins "^[[A" up-line-or-beginning-search
bindkey -M vicmd "^[[A" up-line-or-beginning-search
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M viins "^[[B" down-line-or-beginning-search
bindkey -M vicmd "^[[B" down-line-or-beginning-search
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M viins "${terminfo[kend]}" end-of-line
  bindkey -M vicmd "${terminfo[kend]}" end-of-line
fi
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

######################################################################
# Terminal Title + OSC 7 Support (from OMZ termsupport.zsh) - DISABLED
######################################################################
# function title {
#   setopt localoptions nopromptsubst
#   [[ -n "${INSIDE_EMACS:-}" && "$INSIDE_EMACS" != vterm ]] && return
#   : ${2=$1}
#   case "$TERM" in
#     cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty*|st*|foot*|contour*|wezterm*)
#       print -Pn "\e]2;${2:q}\a"
#       print -Pn "\e]1;${1:q}\a"
#       ;;
#     screen*|tmux*)
#       print -Pn "\ek${1:q}\e\\"
#       ;;
#     *)
#       if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
#         print -Pn "\e]2;${2:q}\a"
#         print -Pn "\e]1;${1:q}\a"
#       else
#         if (( ${+terminfo[fsl]} && ${+terminfo[tsl]} )); then
#           print -Pn "${terminfo[tsl]}$1${terminfo[fsl]}"
#         fi
#       fi
#       ;;
#   esac
# }
#
# ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<"
# ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"
# if [[ "$TERM_PROGRAM" == Apple_Terminal ]]; then
#   ZSH_THEME_TERM_TITLE_IDLE="%n@%m"
# fi
#
# function omz_termsupport_precmd {
#   [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return 0
#   title "$ZSH_THEME_TERM_TAB_TITLE_IDLE" "$ZSH_THEME_TERM_TITLE_IDLE"
# }
#
# function omz_termsupport_preexec {
#   [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return 0
#   emulate -L zsh
#   setopt extended_glob
#
#   local -a cmdargs
#   cmdargs=("${(z)2}")
#   if [[ "${cmdargs[1]}" = fg ]]; then
#     local job_id jobspec="${cmdargs[2]#%}"
#     case "$jobspec" in
#       <->) job_id=${jobspec} ;;
#       ""|%|+) job_id=${(k)jobstates[(r)*:+:*]} ;;
#       -) job_id=${(k)jobstates[(r)*:-:*]} ;;
#       [?]*) job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
#       *) job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
#     esac
#     if [[ -n "${jobtexts[$job_id]}" ]]; then
#       1="${jobtexts[$job_id]}"
#       2="${jobtexts[$job_id]}"
#     fi
#   fi
#
#   local CMD="${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}"
#   local LINE="${2:gs/%/%%}"
#   title "$CMD" "%100>...>${LINE}%<<"
# }
#
# autoload -Uz add-zsh-hook
# if [[ -z "$INSIDE_EMACS" || "$INSIDE_EMACS" = vterm ]]; then
#   add-zsh-hook precmd omz_termsupport_precmd
#   add-zsh-hook preexec omz_termsupport_preexec
# fi
#
# if [[ -z "$INSIDE_EMACS" && -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
#   __omz_termsupport_cwd_enabled=0
#   case "$TERM" in
#     xterm*|putty*|rxvt*|konsole*|mlterm*|alacritty*|screen*|tmux*|contour*|foot*)
#       __omz_termsupport_cwd_enabled=1
#       ;;
#     *)
#       case "$TERM_PROGRAM" in
#         Apple_Terminal|iTerm.app) __omz_termsupport_cwd_enabled=1 ;;
#       esac
#       ;;
#   esac
#
#   if (( __omz_termsupport_cwd_enabled )); then
#     function omz_termsupport_cwd {
#       setopt localoptions unset
#       local URL_HOST URL_PATH
#       URL_HOST="${HOST//%/%25}"
#       URL_PATH="${PWD//%/%25}"
#       URL_HOST="${URL_HOST// /%20}"
#       URL_PATH="${URL_PATH// /%20}"
#       [[ -z "$KONSOLE_PROFILE_NAME" && -z "$KONSOLE_DBUS_SESSION"  ]] || URL_HOST=""
#       printf "\e]7;file://%s%s\e\\" "${URL_HOST}" "${URL_PATH}"
#     }
#     add-zsh-hook precmd omz_termsupport_cwd
#   fi
#   unset __omz_termsupport_cwd_enabled
# fi

######################################################################
# Terminal Title (simple: show current directory only)
######################################################################
ENABLE_OSC7=true

function title {
  setopt localoptions nopromptsubst
  [[ -n "${INSIDE_EMACS:-}" && "$INSIDE_EMACS" != vterm ]] && return
  : ${2=$1}
  case "$TERM" in
    cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty*|st*|foot*|contour*|wezterm*)
      print -Pn "\e]2;${2:q}\a"
      print -Pn "\e]1;${1:q}\a"
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\"
      ;;
    *)
      if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
        print -Pn "\e]2;${2:q}\a"
        print -Pn "\e]1;${1:q}\a"
      else
        if (( ${+terminfo[fsl]} && ${+terminfo[tsl]} )); then
          print -Pn "${terminfo[tsl]}$1${terminfo[fsl]}"
        fi
      fi
      ;;
  esac
}

function omz_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return 0
  title "%~" "%~"
}

autoload -Uz add-zsh-hook
if [[ -z "$INSIDE_EMACS" || "$INSIDE_EMACS" = vterm ]]; then
  add-zsh-hook precmd omz_termsupport_precmd
fi

######################################################################
# OSC 7 (current directory integration for compatible terminals)
######################################################################
if [[ "$ENABLE_OSC7" = true && -z "$INSIDE_EMACS" && -z "$SSH_CLIENT" && -z "$SSH_TTY" ]]; then
  __osc7_enabled=0
  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|mlterm*|alacritty*|screen*|tmux*|contour*|foot*|ghostty*)
      __osc7_enabled=1
      ;;
    *)
      case "$TERM_PROGRAM" in
        Apple_Terminal|iTerm.app) __osc7_enabled=1 ;;
      esac
      ;;
  esac

  if (( __osc7_enabled )); then
    function osc7_cwd {
      setopt localoptions unset
      local URL_HOST URL_PATH
      URL_HOST="${HOST//%/%25}"
      URL_PATH="${PWD//%/%25}"
      URL_HOST="${URL_HOST// /%20}"
      URL_PATH="${URL_PATH// /%20}"
      [[ -z "$KONSOLE_PROFILE_NAME" && -z "$KONSOLE_DBUS_SESSION"  ]] || URL_HOST=""
      printf "\e]7;file://%s%s\e\\" "${URL_HOST}" "${URL_PATH}"
    }
    add-zsh-hook precmd osc7_cwd
  fi
  unset __osc7_enabled
fi

######################################################################
# ls colors (from OMZ theme-and-appearance.zsh)
######################################################################
if [[ "$DISABLE_LS_COLORS" != true ]]; then
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  if [[ -z "$LS_COLORS" ]]; then
    if (( $+commands[dircolors] )); then
      [[ -f "$HOME/.dircolors" ]] \
        && source <(dircolors -b "$HOME/.dircolors") \
        || source <(dircolors -b)
    else
      export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
    fi
  fi
  if command ls -G /dev/null &>/dev/null; then
    alias ls='ls -G'
  fi
fi

######################################################################
# Git prompt (OMZ-compatible minimal)
######################################################################
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

__git_prompt_git() { GIT_OPTIONAL_LOCKS=0 command git "$@"; }

parse_git_dirty() {
  local STATUS
  STATUS=$(__git_prompt_git status --porcelain --ignore-submodules=dirty 2>/dev/null | tail -n 1)
  [[ -n "$STATUS" ]] && echo "$ZSH_THEME_GIT_PROMPT_DIRTY" || echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
}

git_prompt_info() {
  __git_prompt_git rev-parse --git-dir &>/dev/null || return 0
  local ref
  ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null) \
    || ref=$(__git_prompt_git describe --tags --exact-match HEAD 2> /dev/null) \
    || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) \
    || return 0
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref:gs/%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

######################################################################
# Limited plugin features + completions
######################################################################

# Docker completions
if (( $+commands[docker] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_docker" ]]; then
    typeset -g -A _comps
    autoload -Uz _docker
    _comps[docker]=_docker
    (command docker completion zsh >| "$ZSH_CACHE_DIR/completions/_docker") &|
  fi
fi

# Go completions
compctl -g "*.go" gofmt
compctl -g "*.go" gccgo
for p in 5 6 8; do
  compctl -g "*.${p}" ${p}l
  compctl -g "*.go" ${p}g
done
unset p

# Terraform completions (if available in fpath)
if (( $+commands[terraform] )); then
  if autoload -Uz _terraform 2>/dev/null; then
    typeset -g -A _comps
    _comps[terraform]=_terraform
  fi
fi
