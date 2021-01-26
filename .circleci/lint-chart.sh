#!/bin/sh
# Usage:
#   lint-chart.sh [dir]
#  Description:
#    Check that the number of nindents matches the actual indents
#

err=$(for file in "${1}"/*.yaml; do
  i="0"
  while IFS= read -r line; do
    i="$(expr "${i}" + 1)"
    if echo "${line}" | grep nindent >/dev/null; then
      indent=$(echo "${line}" | grep -o '^ \+' | awk '{print length($0)}')
      args=$(echo "${line}"| grep -o 'nindent [0-9]\+' | grep -o '[0-9]\+')
      # Check that the number of nindents matches the actual indents
      if [ "${indent}" != "${args}" ]; then
        printf "%s on line %d: indent mismatch:\n%s\n" "${file}" "${i}" "${line}"
      fi
      # nindent should use {{ instead of {{-
      if ! (echo "$line" | grep '{{-') > /dev/null; then
       printf "%s on line %d: \`{{-\` should be used for nindent:\n%s\n" "${file}" "${i}" "${line}"
      fi
    fi
  done < "${file}"
done)


if [ -n "${err}" ]; then
  echo "${err}" 1>&2
  exit 255
else
  echo "PASS ${1}"
fi