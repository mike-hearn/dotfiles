# Executes on each cd to a new dir
chpwd() {
	_activate_virtual_environment
}

_activate_virtual_environment() {
	toplevel=$(git rev-parse --show-toplevel 2> /dev/null)
	source $toplevel/venv/bin/activate 2> /dev/null
	source $toplevel/.venv/bin/activate 2> /dev/null
}

# Execute once on shell launch
chpwd
