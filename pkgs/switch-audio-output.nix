{ pkgs }:
pkgs.writeShellApplication {
  name = "switch-audio-output";
  runtimeInputs = with pkgs; [ dmenu gawk ];
  text = ''
    SINKS=$(pactl list short sinks | awk '{print $1 ":" $2}')
    CHOSEN=$(echo "$SINKS" | dmenu -i -p "audio output:")
    SINK_ID=$(echo "$CHOSEN" | cut -d ':' -f 1)

    if [ -n "$SINK_ID" ]; then
        pactl set-default-sink "$SINK_ID"
        for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
            pactl move-sink-input "$INPUT" "$SINK_ID"
        done
    fi
  '';
}
