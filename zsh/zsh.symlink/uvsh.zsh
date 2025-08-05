# Recursively searches for a '.venv' directory, starting from current directory.
# If found, the virtual env is activated if a virtually env is not already loaded.
#
# 02.06.2025 Stian Lode <stian.lode@boost.ai>


upfind () { 
  [ $(dirname "$(realpath $1)") = "/" ] ||
    readlink -e $1 ||
    upfind ../$1
}

uva() {
  local green='\033[0;32m'
  local yellow='\033[0;33m'
  local red='\033[0;31m'
  local reset='\033[0m'

  if [ -n "${VIRTUAL_ENV}" ]; then
    echo -e "${yellow}Virtual env '${VIRTUAL_ENV}' is already activated!${reset}" && return 1
  fi

  local venv_name="${VENV_NAME:-.venv}"
  local activator="$(upfind ${venv_name})/bin/activate"

  if [ ! -f ${activator} ]; then
    echo -e "${red}Virtual env '${venv_name}' not found!${reset}" && return 2
  fi

  echo -e "${green}Activating virtual env '${activator}${reset}'"
  source "${activator}"
}
