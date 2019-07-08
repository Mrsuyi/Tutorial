#!/usr/bin/env sh

find . -name '*.h' -or -name '*.m' | xargs clang-format -i
