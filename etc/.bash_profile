# ============================================================================ #
#                                                                              #
#                          Starter Kit - Bash Profile                          #
#                          --------------------------                          #
#                                                                              #
# ============================================================================ #

# Bash stands for "Bourne-Again SHell". A shell is a way to talk more directly
# to the operating system, in this case via a "command-line" interface. A
# command-line interface is like a text-based Alexa: you issue a command from
# the set of available commands and get back a response. Whereas you might say
# `Alexa, Simon Says "Hello, World"` and hear back "Hello, World", in Bash
# you would type `echo "Hello, World"` and see "Hello, World" printed out.
#
# Your Bash Profile is a set of configurations for your Bash terminal. This
# file runs before every new session. A session in your terminal is similar to
# a "session" in your web browser where you can sign in to a website, click a
# link to another site, and when you go back not need to re-authenticate.
#
# To reload, such as after you update this file, run `source ~/.bash_profile`
# in your terminal:
#   $ source ~/.bash_profile


# Variables can be defined with the format `VARIABLE_NAME=Value`. To get the
# value of a variable, use `$VARIABLE_NAME`.
#
# Example:
#   $ NAME="Erica"
#   $ echo $NAME
#   Erica
#
# If you define a variable in another file or terminal, it won't be available
# in other places.
#
# You can make a variable available by adding it to your enviroment by exporting
# it. When you export a variable in a file by adding the line
# `export VARIABLE_NAME=Value`, it will be available when you load that file
# into your terminal with `source <filename>`.
#
# To see your environment and the values of any variables, run `env`:
#   $ env

# *** Note ***
# Bash loads this file before every session, so any variables you export here
# will be available in all terminal sessions.

# These variables and their values are available to any program or command that
# runs in your session. Many programs use environment variables to set some
# configuration.
#
# For example, the Go programming language uses an environment variable
# [`$GOPATH`](https://github.com/golang/go/wiki/GOPATH) to indicate which file
# directory to contains your Go code (e.g. setting `GOPATH=~/go` puts Go source
# code in the `go` directory in your home path).
#
# A common use case for environment variables is to store credentials like
# username/password pairs, API keys, and auth tokens. It is often more secure to
# store credentials in the environment (where only privileged users with access
# to the computer running the program can access them), rather than storing them
# in the source code (often shared across many computers and stored on external
# servers like Github where it is easy to accidentally make them public);
# although there are other more sophisticated ways used in many modern systems.

# Some variables are automatically set by your terminal. Some important ones:
#  `HOME` - Your home directory. In OSX it is usually `/Users/<computer user>`.
#           This is the directory that contains all the files specific to the
#           current user, like personal documents and individual settings. You
#           can reference the home directory by using `~`, e.g. `ls ~/Desktop`
#           shows you what files are on your desktop. Run `echo $HOME` to see
#           the value set.
#
#  `PWD`  - Current directory. This is the file directory you are currently in.
#           File paths that are not absolute paths (absolute paths start with a
#           `/`, like `/Users/ericavonb/Desktop`) are relative to the current
#           directory. So when in your home directory, running `ls` is the same
#           as running `ls ~/` or `ls /Users/<user>`/ (since `~` references the
#           `HOME` directory).
#
#           The current directory can also be represented in file paths by `.`.
#           When in your home directory, `ls ./Applications` is the same as
#           running `ls Applications` or `ls $PWD/Applications`.
#           To reference the parent directory, use `..`. So if the current
#           directory is `~/Desktop`, you can reference the `~/Downloads`
#           directory with `../Downloads`.



# ______________________________ Custom Prompt _______________________________ #

# The first env var we are going to set is `PS1` for your prompt. The prompt is
# the text that starts new command lines in your terminal. It is "prompting" you
# to enter a command to run. It's kinda like the "Alexa" or "Ok, Google" before
# giving a command, except it's printed for you automatically.


# These are codes that change the color of the text in your terminal.

# *** Note ***
# You must use `echo -e`, not just `echo`, if you include a color.

# Example:
#   $ echo -e "Roses are $REDred$RESET. Violets are $BLUEblue$RESET."


# Reset colors back to default
export RESET_COLORS="\033[m" # only color
export RESET="\033[0m" # color + style

# Set style
export BOLD="\033[1m"

# available colors
export BLACK="\033[30m"
export BOLD_BLACK="\033[1;30m"
export RED="\033[0;31m"
export BOLD_RED="\033[1;31m"
export GREEN="\033[0;32m"
export BOLD_GREEN="\033[1;32m"
export YELLOW="\033[0;33m"
export BOLD_YELLOW="\033[1;33m"
export BLUE="\033[0;34m"
export BOLD_BLUE="\033[1;34m"
export MAGENTA="\033[0;35m"
export BOLD_MAGENTA="\033[1;35m"
export CYAN="\033[0;36m"
export BOLD_CYAN="\033[1;36m"
export WHITE="\033[0;37m"
export BOLD_WHITE="\033[1;37m"

# *** NOTE ***
#  We exported the colors so that they could be referenced on the command line
# by other programs. We are NOT exporting these variables because we're only
# using them in this file as a convenience and don't expect any other program
# to know, or want to know, about them.

# Replace these colors with colors of your choice from above
DATETIME_COLOR=$BOLD_BLACK
CURRENT_DIR_COLOR=$RED
PROMPT_COLOR=$RED


# Git is a commonly used version control system. It allows you to track changes
# and different versions of your code. The `branch` is which version of the code
# is currently represented in the directory you're in.

# Get the branch name for the current Git repo
function find_git_branch {
    BRANCH=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    UNCOMMITED_CHANGES=${BRANCH+$(git status --porcelain 2> /dev/null)}
    PS_GIT=${BRANCH:+"("}${UNCOMMITED_CHANGES:+"*"}$BRANCH${BRANCH:+")"}
    echo -ne "$PS_GIT"
}
GIT_BRANCH_COLOR=$YELLOW


# Main prompt format:
# [HH:MM:SS AM(PM)] (<git branch>) <abbrev current working directory> $ <cursor>
#
# Example:
# [02:24:48 PM] ~ $ echo "Hello World"
# Hello World
# [02:25:14 PM] ~ $ cd Music/iTunes
# [02:25:21 PM] ~/Music/iTunes $ pwd
# /Users/kristenstark/Music/iTunes
# [02:25:14 PM] ~/Music/iTunes $ _

CUSTOM_PROMPT="\[$DATETIME_COLOR\][\D{%r}] \[$GIT_BRANCH_COLOR\]\$(find_git_branch) \[$CURRENT_DIR_COLOR\]\w \[$PROMPT_COLOR\]\$ \[$RESET\]"

export PS1="$CUSTOM_PROMPT" # comment this line out to set prompt back to default


# ___________________________________ Paths ___________________________________ #

# Your PATH is where bash looks for the executable for any commands entered.
#
# Example:
# If you set your PATH to a directory 'bin' located in your home directory,
#   $ export PATH=~/bin
# and you type a command
#   $ shout "where am i?"
# Bash looks for a file named `shout` in the '~/bin' directory, i.e. `~/bin/shout`.
# If that file exists, bash executes (runs the code in) that file.
#
# Try entering:
#   $ which cd
# to see the file that gets executed when you enter the command `cd`. You should
# get something like, `/usr/bin/cd`.
#
# If you want to add another directory containing some commands, you append that
# directory onto the PATH with a colon:
#   $ export PATH=/new/directory:$PATH
# This allows you to write your own commands and keep them in the folder of your
# choice.



# Add Homebrew installed files to path

# [Homebrew](http://brew.sh/) is a convienient package installer for Mac.
# Download it by running the following command in your terminal:
# ```
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
# ```
# Now you can download programs by running `brew install`. Try running
# `brew install git` if you don't have git installed yet.

# Homebrew installs commands for programs you download via `brew install` into
# `/usr/local/bin` or `/usr/local/sbin`. Add those to your PATH so that you
# can run any command installed by Homebrew.

export PATH=/usr/local/bin:/usr/local/sbin:$PATH


# ______________________________ Custom Commands _______________________________ #

# An `alias` is like a shortcut. Bash will replace an alias with its value before
# running the command.
#
# For example, if you have:
#   $ alias linecount="wc -l"
# Then running:
#   $ linecount myfile.txt
# will print out the number of lines in `myfile.txt` as if you had entered
# `wc -l myfile.txt`.


# Some helpful aliases (delete or comment out any you don't want)

# color `ls` output by default
alias ls='ls -G'

# color matches from `grep`, show full filename and line number
alias grep="grep --color=true --full-name --heading -n"

# find a command in your bash history
alias when="history | grep $0"

# encode/decode a url (e.g. "urlencode {"type":"sftp"}" outputs "%7Btype%3Asftp%7D")
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'


# __________________________________ Editor ___________________________________ #

# This is the text editor that will be used to open text files for editing.

# Set Sublime as the default text editor. Replace with `emacs`, `vim`, or other
# editor if you want. You can download Sublime Text 2 at
#   https://download.sublimetext.com/Sublime%20Text%202.0.2.dmg

export EDITOR='subl -w'
