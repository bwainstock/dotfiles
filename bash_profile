# +---------------------------------+
# |                                 |
# |       project-cookiecutter      |
# |                                 |
# +---------------------------------+
function cookie {
	local COMMAND="$1"
	local GITREPO="https://github.pie.apple.com/bwainstock/project-cookiecutter.git"
	local PROJECTDIR="./.project-cookiecutter"
	local LOG="/Users/sisuser/Barry/project-cookiecutter.log"
	local ENV="$PROJECTDIR"/env
	if [ "$COMMAND" = 'init' ]; then
		git clone "$GITREPO" "$PROJECTDIR"
		virtualenv -ppython3 "$ENV"
		"$ENV"/bin/pip install -r "$PROJECTDIR"/requirements.txt
	fi

	if [ "$COMMAND" = 'update' ]; then
		git -C "$PROJECTDIR" pull
	fi

	if [ "$COMMAND" = 'run' ]; then
		touch "$LOG"
		pwd >> "$LOG"
		echo "Starting web server at http://localhost:5000"
		FLASK_APP="$PROJECTDIR"/run.py "$ENV"/bin/flask initdb
		FLASK_APP="$PROJECTDIR"/run.py "$ENV"/bin/flask run >> "$LOG" 2>&1
	fi

	if [ -z "$COMMAND" ]; then
		echo "No command found: did you mean 'cookie run'?"
	fi
}


# +---------------------------------+
# |                                 |
# |            ALIASES              |
# |                                 |
# +---------------------------------+
alias laptop='bash <(curl -s https://raw.githubusercontent.com/18F/laptop/master/laptop)'
#alias ara='ara-manage runserver'
alias ansible-tasks='ansible-playbook --list-tasks'
alias ll='ls -alrt'
alias adoc='ansible-doc'
alias cssh='csshX -l c4553008 --hosts'
alias table='column -ts ","'
#alias hosts='/usr/bin/hosts.py'
alias cobbler-python='source ~/Barry/gcs-cobbler/env/bin/activate'
function vlan {
	local VLAN="$1"
	grep -i "$VLAN" /Users/sisuser/svn-checkout/ngsglobal/etc/subnets
}
function subnet {
	local SUBNET="$1"
	curl subnet.im/"$SUBNET"
}
function cs {
	TICKET_NUMBER=$(basename "$PWD" | cut -d"_" -f1)
	open https://cst.apple.com/tkt.do?tkt="$TICKET_NUMBER"
}
function cr {
	local CR_DIR=/Users/sisuser/Barry/CR
	local CR="$1"
	if [ -n "$CR" ]; then
		cd "$CR_DIR"/"$CR" || exit
	else
		cd "$CR_DIR" || exit
	fi
}


# +---------------------------------+
# |                                 |
# |              PATH               |
# |                                 |
# +---------------------------------+
export PATH="$HOME/.bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH=~/.local/bin:$PATH
export PATH=~/Barry/Projects/ilo-tools:$PATH
export PATH=~/Barry/gcs-cobbler:$PATH
export PATH=~/go/bin:$PATH


# +---------------------------------+
# |                                 |
# |          ENV MANAGERS           |
# |                                 |
# +---------------------------------+
export NVM_DIR="/Users/sisuser/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# +---------------------------------+
# |                                 |
# |           COLORIZE              |
# |                                 |
# +---------------------------------+
# Enable colors in ls command
export CLICOLOR=1


# Enable bash completion for various commands
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#Less syntax highlighting
export LESSOPEN="| pygmentize -f terminal256 -O style=native -g %s"
export LESS=' -R -X -F '


# +---------------------------------+
# |                                 |
# |           POWERLINE             |
# |                                 |
# +---------------------------------+
#PS1="\[\e[1;30m\][$$:$PPID - \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY:-o} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ "

function _update_ps1() {
    PS1="$(/usr/bin/powerline-go -newline -cwd-max-depth 7 -colorize-hostname -modules time,venv,user,ssh,cwd,perms,git,hg,jobs,exit,root -error $?)"
     #PS1="$(~/go/bin/powerline-go -error $? -newline -cwd-max-depth 7 -colorize-hostname -modules time,venv,user,ssh,cwd,perms,git,hg,jobs,exit,root)"

}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# +---------------------------------+
# |                                 |
# |             GCLOUD              |
# |                                 |
# +---------------------------------+
source /usr/share/google-cloud-sdk/completion.bash.inc

export SVN_EDITOR=vim
# <------------------END------------------------->

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# +---------------------------------+
# |                                 |
# |             FZF                 |
# |                                 |
# +---------------------------------+
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"


# fco - checkout git branch (including remote branches)
fco() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

