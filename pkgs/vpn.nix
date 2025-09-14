{ pkgs }:
pkgs.writeShellApplication {
  name = "vpn";
  runtimeInputs = with pkgs; [ libnotify dmenu xclip wl-clipboard ];
  text = ''
    vpns=$(nmcli --fields NAME,TYPE connection show | awk '$2=="vpn"{print $1}')

    if [[ -z "$vpns" ]]; then
        notify-send "VPN" "No VPN found"
        exit 1
    fi

    chosen=$(echo "$vpns" | dmenu -i -p "Toggle VPN:")

    if [[ -z "$chosen" ]]; then
        exit 0
    fi

    route_cmd="sudo ip route add default via 192.168.1.254 dev enp3s0"

    if nmcli connection show --active | grep -q "^$chosen "; then
        if nmcli connection down id "$chosen"; then
            notify-send "VPN" "VPN '$chosen' disconnected"
        else
            notify-send "VPN" "Error disconnecting '$chosen'"
            exit 1
        fi
    else
        if nmcli connection up id "$chosen"; then
            notify-send "VPN" "VPN '$chosen' activated"
            if command -v xclip >/dev/null 2>&1; then
                echo "$route_cmd" | xclip -selection clipboard
                notify-send "VPN" "Route command copied to clipboard"
            elif command -v wl-copy >/dev/null 2>&1; then
                echo "$route_cmd" | wl-copy
                notify-send "VPN" "Route command copied to clipboard"
            else
                notify-send "VPN" "No clipboard tool found to copy route command"
            fi
        else
            notify-send "VPN" "Error activating '$chosen'"
            exit 1
        fi
    fi
  '';
}
