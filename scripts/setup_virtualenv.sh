#!/bin/bash

# ==============================================================================
# libjam - C++ library for jamming over SIP protocol
#
# Copyright (C) 2020, Ryan P. Wilson
#   Authority FX, Inc.
#   www.authorityfx.com
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# ==============================================================================

set -o pipefail
set -o errtrace
set -o errexit

bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
green=$(tput setaf 2)

_CURRENT_DIR="$(pwd)"
_SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_PROJECT_ROOT="$( cd "$_SCRIPTS_DIR/../" && pwd )"

_ENV_PATH="${_PROJECT_ROOT}/.env"
_ENV_BAK_PATH="${_PROJECT_ROOT}/.env_bak"

cleanup() {
    if [ -d "${_ENV_BAK_PATH}" ]; then
        rm -Rf "${_ENV_BAK_PATH}"
    fi
}
trap cleanup 0

handle_error() {
    local _parent_lineno="$1"
    local _message="${2:-}"
    local _code="${3:-1}"
    if [[ -n "$_message" ]] ; then
        echo "${red}Error${normal} on line ${bold}${_parent_lineno}${normal}: ${message}; exiting with status ${red}${_code}${normal}"
    else
        echo "${red}Error${normal} on line ${bold}${_parent_lineno}${normal}; exiting with status ${red}${_code}${normal}"
    fi
    exit "${_code}"
}
trap 'handle_error ${LINENO}' ERR

if [ -d "${_ENV_PATH}" ]; then
    echo "${blue}Backing-up${normal} ${bold}.env${normal}..."
    mv "${_ENV_PATH}" "${_ENV_BAK_PATH}"
fi

echo "${blue}Creating${normal} ${bold}virtualenv${normal}..."
virtualenv -p python3 "${_ENV_PATH}"

source "${_SCRIPTS_DIR}/../.env/bin/activate"
echo -e "${blue}Upgrading pip${normal}"
pip install --upgrade pip
echo -e "${blue}Installing${normal}:\n${bold}$(cat ${_SCRIPTS_DIR}/../requirements.txt)${normal}"
pip install -r "${_PROJECT_ROOT}/requirements.txt"

echo "${green}Success!${normal}"
