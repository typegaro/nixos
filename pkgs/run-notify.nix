{ pkgs }:

pkgs.writeShellApplication {
  name = "run-notify";
  # notify-send
  runtimeInputs = with pkgs; [ libnotify ];

  # Niente shebang qui: lo aggiunge writeShellApplication.
  text = ''
    if [ "$#" -lt 2 ]; then
      echo "Uso: $0 <comando> <testo-notifica>"
      exit 1
    fi

    cmd="$1"
    shift
    text="$*"

    notify-send "Command" "$text"

    # Esegue il comando passato come stringa (più sicuro di eval)
    sh -c "$cmd"

    # Se vuoi esattamente il tuo eval:
    # eval "$cmd"
  '';
}
