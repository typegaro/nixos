{ pkgs }:
pkgs.writeShellApplication {
  name = "bookmarks";
  runtimeInputs = with pkgs; [ dmenu xdotool coreutils ];
  text = ''
    set -euo pipefail

    bookmark_dir="$HOME/.scripts/bookmarks"
    if [ ! -f "$bookmark_dir" ]; then
      echo "Lista bookmark non trovata: $bookmark_dir" >&2
      exit 1
    fi

    # Evita 'cat file | ...' (SC2002)
    choice=$(dmenu -p "Bookmark:" -l 10 -i < "$bookmark_dir")
    if [ -z "$choice" ]; then
      exit 0
    fi

    xdotool type "$choice"
  '';
}