#!/usr/bin/env sh

if [ $# == 0 ]; then
  git ls-files --other --modified --exclude-standard | xargs clang-format -i
elif [ $1 == 'all' ]; then
  find . -name '*.h' -or -name '*.m' -or -name '*.html' | xargs clang-format -i
else
  echo 'usage: format.sh\n'
        '      format.sh all'
fi
