#!/bin/bash
source /opt/rh/rh-mariadb100/enable

if [[ "$X_SCLS" != *rh-mariadb100* ]]; then
  src="`scl enable rh-mariadb100 'echo $X_SCLS'`"
  pkgs=(${src// / })
  uniq=($(printf "%s\n" "${pkgs[@]}" | sort -u));
  export X_SCLS="${uniq[@]}"
fi