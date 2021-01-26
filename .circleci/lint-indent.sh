#!/bin/sh
# Usage:
#   lint-indent.sh [dir]
#  Description:
#    Check that the number of nindents matches the actual indents
#

for file in "${1}"/*.yaml; do
  grep nindent < "${file}" | while IFS= read -r line; do
    indent=$(echo "${line}" | grep -o '^ \+' | awk '{print length($0)}')
    args=$(echo "${line}"| grep -o 'nindent [0-9]\+' | grep -o '[0-9]\+')
    if [ "${indent}" != "${args}" ]; then
      printf "%s: indent mismatch: ${indent}:$args \n%s\n" "${file}" "${line}" 1>&2
      exit 255
    fi
  done
done
