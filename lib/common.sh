# Convenience functions reusable in any shell context (i.e., not dependent on
# script-specific environment variables)

[[ -n "$LIBGITPCLONE_COMMON_SH" ]] && return

LIBGITPCLONE_COMMON_SH=1

join_array() {
  local -r _delimiter="$1"
  local -ra _arr=("${@:2}")

  (
    IFS="$_delimiter"
    echo "${_arr[*]}"
  )
}

build_path() {
  local -ar _segments=("$@")

  # HACK - overwriting a global variable with a local one
  # Any cleaner way I can find to do this is also unnecessarily verbose
  join_array '/' "${_segments[@]}"
}

get_index() {
  local -r _needle="$1"

  [[ -z "$_needle" ]] &&
    echo -1 &&
    return 1

  local -r _haystack=("${@:2}")

  [[ ${#_haystack[@]} -le 0 ]] &&
    echo -1 &&
    return 1

  for x in "${!_haystack[@]}"; do
    if [[ "${_haystack[$x]}" = "$_needle" ]]; then
      echo "$x"
    fi
  done
}
