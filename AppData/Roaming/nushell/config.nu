# config.nu
#
# Installed by:
# version = "0.116.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.show_banner = false
$env.config.shell_integration.osc133 = false
$env.config.buffer_editor = 'nvim'
$env.PROMPT_COMMAND_RIGHT = ""

alias v = nvim

# Git
alias g = git
alias ga = git add
alias gaa = git add --all
alias grm = git rm --cached
alias gb = git branch
alias gc = git commit --verbose
alias gca = git commit --verbose --all
alias gcl = git clone --recurse-submodules
alias gm = git merge
alias gl = git pull
alias gup = git pull --rebase
alias gp = git push
alias gf = git fetch
alias gco = git checkout
alias gst = git status
alias gd = git diff
alias gdc = git diff --cached
alias glg = git log --graph
alias gr = git remote

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}
