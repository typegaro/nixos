{ pkgs }:
pkgs.writeShellApplication {
  name = "config";
  runtimeInputs = with pkgs; [ dmenu neovim coreutils ];
  text = ''
    set -euo pipefail

    config_dir="$HOME/.scripts/config"
    if [ ! -f "$config_dir" ]; then
      echo "Lista config non trovata: $config_dir" >&2
      exit 1
    fi

    # Evita 'cat file | ...' (SC2002)
    choice=$(dmenu -p "Config:" -l 10 -i < "$config_dir")
    if [ -z "$choice" ]; then
      exit 0
    fi

    "${TERMINAL:-xterm}" -e nvim "$choice"
  '';
}