{ pkgs }:
pkgs.writeShellApplication {
  name = "mount";
  runtimeInputs = with pkgs; [ dmenu gnugrep libnotify ];
  text = ''
    entries=$(lsblk -rpo NAME,TYPE,SIZE,MOUNTPOINT | awk '$2 == "part" && $4 == "" {print $1 " (" $3 ")"}')

    [ -z "$entries" ] && notify-send "No partition to mount" && exit

    chosen=$(echo "$entries" | dmenu -l 10 -i -p "Mount:")

    [ -z "$chosen" ] && exit

    device=$(echo "$chosen" | awk '{print $1}')
    name=$(basename "$device")
    mountpoint="/mnt/$name"
    sudo mkdir -p "$mountpoint"
    sudo mount "$device" "$mountpoint"

    if mount | grep -q "$mountpoint"; then
        notify-send "Mounted $device on $mountpoint"
    else
        notify-send "Error mounting $device"
    fi
  '';
}
