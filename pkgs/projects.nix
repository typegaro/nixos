{ pkgs }:
pkgs.writeShellApplication {
  name = "projects";
  runtimeInputs = with pkgs; [ findutils dmenu tmux libnotify coreutils ];
  text = ''
    set -euo pipefail

    # Elenca le directory di progetto (usa $HOME, non ~)
    search_dirs=(
      "$HOME/Prj"
      "$HOME/Work"
      "$HOME/Work/backend"
      "$HOME/Work/sdk"
      "$HOME/Amber"
    )

    # Usa mapfile con delimitatore NUL (evita problemi di quoting con Nix e gestisce spazi nei path)
    mapfile -d $'\0' -t dirs < <(find "''${search_dirs[@]}" -maxdepth 1 -type d -print0)

    # Selezione con dmenu
    path="$(printf '%s\n' "''${dirs[@]}" | dmenu -l 10 -i)"
    [ -z "$path" ] && exit 0

    base="$(basename -- "$path")"

    # Crea la sessione tmux in background
    tmux new-session -c "$path" -s "$base" -d

    notify-send "tmux session started" "Session: $base"

    # Conta le sessioni (tmux ls fallisce se non ce ne sono)
    sessions_count="$( { tmux ls 2>/dev/null || true; } | wc -l )"
    if [ "$sessions_count" -eq 1 ]; then
      "${TERMINAL:-xterm}" -e tmux attach -t "$base" &
    fi
  '';
}