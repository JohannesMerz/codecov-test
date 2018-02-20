#! /bin/bash
set -e

FILE_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PROJECT_ROOT=$FILE_ROOT/..

#### FUNCTIONS

# searches for all dirs containing a package.json (ignores node_modules) and passes the dir to a given command
function runForAll {
  find $PROJECT_ROOT -path '*/package.json' -not -path '*/node_modules/*' | while read file; do $1 "$(dirname ${file})" ; done
}

function test {
  echo "running tests for $1"
  cd $1 && CI=true yarn test
}

function install {
  echo "installing packages in $1"
  cd $1 && yarn install --pure-lockfile
}


function help {
  echo "script for install and run things"
  echo "run run.sh COMMAND"
  echo "where COMMAND is one of:"
  echo "  - install: installs all dependencies"
  echo "  - test: runs all unit tests"
}

#### FLOW
case $1 in
  test )
    runForAll test
    ;;
  install )
    runForAll install
    ;;
  help | --help )
    help
    ;;
esac
