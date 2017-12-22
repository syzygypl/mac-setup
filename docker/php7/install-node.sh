info() {
    [[ -n "${TRACE:-}" ]] && echo "$@" >&2 || :
}

needs_resolution() {
    local semver=$1
    if ! [[ "$semver" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      return 0
    else
      return 1
    fi
}

resolve_node_version() {
    local cache_dir=".node_semver/" cache_name=$(echo "$node_version" | base64) cache_path="${cache_dir}${cache_name}"

    mkdir -p "$cache_dir"

    if find "$cache_dir" -name "$cache_name" -mtime +1 -print | grep -q "$cache_name"; then
        cat "$cache_path"
        return;
    fi

    curl --silent --get --retry 5 --retry-max-time 15 --data-urlencode "range=${version}" https://semver.herokuapp.com/node/resolve | tee "$cache_path"
}

install_nodejs() {
    local version="$1"

    if needs_resolution "$version"; then
      info "Resolving node version ${version:-(latest stable)} via semver.io..."
      local version=$(resolve_node_version "$version")
    fi

    if [[ $(node --version) != "v$version" ]]; then
      info "Downloading and installing node $version..."
      n "$version"
    fi
}

main() {
    if [ -f "package.json" ]; then
        install_nodejs "$(jq --raw-output '.engines.node // ""' < package.json)"
    fi
}

main "$@"
