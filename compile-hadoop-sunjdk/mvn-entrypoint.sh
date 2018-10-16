#! /bin/bash -eu

set -o pipefail

# Copy files from /usr/local/maven/ref into ${MAVEN_CONFIG}
# So the initial ~/.m2 is set with expected content.
# Don't override, as this is just a reference setup
copy_reference_file() {
  local root="${1}"
  local f="${2%/}"
  local logfile="${3}"
  local rel="${f/${root}/}" # path relative to /usr/local/maven/ref/
  echo "$f" >> "$logfile"
  echo " $f -> $rel" >> "$logfile"
  if [[ ! -e ${MVN_CONFIG}/${rel} || $f = *.override ]]
  then
    echo "copy $rel to ${MVN_CONFIG}" >> "$logfile"
    mkdir -p "${MVN_CONFIG}/$(dirname "${rel}")"
    cp -r "${f}" "${MVN_CONFIG}/${rel}";
  fi;
}

copy_reference_files() {
  local log="$MVN_CONFIG/copy_reference_file.log"

  if (sh -c "mkdir -p \"$MVN_CONFIG\" && touch \"${log}\"" > /dev/null 2>&1)
  then
      echo "--- Copying files at $(date)" >> "$log"
      find /usr/local/maven/ref/ -type f -exec bash -eu -c 'copy_reference_file /usr/share/maven/ref/ "$1" "$2"' _ {} "$log" \;
  else
    echo "Can not write to ${log}. Wrong volume permissions? Carrying on ..."
  fi
}

export -f copy_reference_file
copy_reference_files
unset MAVEN_CONFIG

exec "$@"

