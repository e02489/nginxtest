#!/bin/sh

set -ex

auto_envsubst() {
  local template_dir="${NGINX_ENVSUBST_TEMPLATE_DIR:-/etc/nginx/templates}"
  local suffix="${NGINX_ENVSUBST_TEMPLATE_SUFFIX:-.template}"
  local output_dir="${NGINX_ENVSUBST_OUTPUT_DIR:-/etc/nginx/conf.d}"

  local template defined_envs relative_path output_path subdir
  defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
  [ -d "$template_dir" ] || return 0
  if [ ! -w "$output_dir" ]; then
    echo "ERROR: $template_dir exists, but $output_dir is not writable. exiting..." 1>&2
    return 1
  fi
  for template in $(find "$template_dir" -follow -name "*$suffix"); do
    relative_path="${template#$template_dir/}"
    output_path="$output_dir/${relative_path%$suffix}"
    subdir=$(dirname "$relative_path")
    # create a subdirectory where the template file exists
    mkdir -p "$output_dir/$subdir"
    envsubst "$defined_envs" < "$template" > "$output_path"
  done
}

auto_envsubst

exec "$@"
