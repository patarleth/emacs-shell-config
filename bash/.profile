# MacPorts Installer addition on 2013-02-15_at_21:50:18: adding an appropriate PATH variable for use with MacPorts.
export EDITOR=emacs
export PATH=/opt/local/bin:/opt/local/sbin:/Applications/dart-sdk/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
#export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
export JAVA_HOME=$(/usr/libexec/java_home -v 1.7.0)
alias ls="ls -G"
set -o emacs
# http://maketecheasier.com/8-useful-and-interesting-bash-prompts/2009/09/04

source /usr/share/git-core/git-completion.bash
source /usr/share/git-core/git-prompt.sh

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\033[0m\]"

git_prompt() {
    git_status_output=$(git status 2> /dev/null) || return

    branch_name() {
        sed -n 's/# On branch //p' <<< "$git_status_output"
    }

    number_of_commits() {
        local branch_prefix='# Your branch is '
        local branch_suffix='by [[:digit:]]+'
        if [[ "$git_status_output" =~ ${branch_prefix}"$1".*${branch_suffix} ]]
        then
            echo ${BASH_REMATCH[0]}| grep -o '[0-9]*$'
        else
            echo 0 && return 1
        fi
    }

    match_against_status() {
        local pattern="$1"
        [[ "$git_status_output" =~ ${pattern} ]]
    }

    working_dir_clean() {
        match_against_status '(working directory clean)'
    }

    local_changes() {
        local added='# Changes to be committed'
        local not_added='# Changes not staged for commit'
        match_against_status "($added|$not_added)"
    }

    untracked_files() {
        match_against_status '# Untracked files'
    }

    dashline() {
        eval printf '%.0s-' {1..$1}
    }

    local bold="\033[1m"
    local no_colour="\033[0m"

    ahead_arrow() {
        if commits_ahead=$(number_of_commits "ahead")
        then
            echo -e "$bold$(dashline $commits_ahead)$no_colour> $commits_ahead ahead"
        fi
    }

    behind_arrow() {
        if commits_behind=$(number_of_commits "behind")
        then
            echo "$commits_behind behind <$bold$(dashline $commits_behind)$no_colour"
        fi
    }

    branch_part() {
        local white="\033[37m"
        local red="\033[31m"
        local green="\033[32m"
        local yellow="\033[33m"
        local branch_colour=""

        if untracked_files
        then
            branch_colour=$RED
        elif local_changes
        then
            branch_colour=$yellow
        elif working_dir_clean
        then
            branch_colour=$green
        fi
        echo "$branch_colour$(branch_name)$no_colour"
    }

    local behind_part=$(behind_arrow)
    local ahead_part=$(ahead_arrow)

    if [[ ! "$behind_part" && ! "$ahead_part" ]]
    then
        prompt="$(branch_part)"
    else
        prompt="$behind_part$ahead_part -- $(branch_part)"
    fi

    echo -e "$no_colour($prompt$white)$no_colour"
}

PS1="\n${WHITE}\342\224\214($(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;34m\]\u@\h'; fi)${WHITE})\$([[ \$? != 0 ]] && echo \"\342\224\200(${RED}\342\234\227${WHITE})\")\342\224\200(${BLUE}\@ \d${WHITE})\$(__git_ps1 \" ${WHITE}~ \`git_prompt\`\")\n\342\224\224\342\224\200(${LIGHT_GREEN}\w${WHITE})\342\224\200(${LIGHT_GREEN}\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -lah | grep -m 1 total | sed 's/total //')b${WHITE})\342\224\200> ${COLOR_NONE}"

export LDFLAGS="-L/opt/local/lib"
