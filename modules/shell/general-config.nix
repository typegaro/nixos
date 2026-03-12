{ config, lib, ... }:
let
  cfg = config."shell-general";
in
{
  options."shell-general" = {
    enable = lib.mkEnableOption "Enable shared shell configuration";

    nixSwitchCommand = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Command used by the nixs alias to switch the system or home configuration.";
    };

    startupCommand = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = ", fastfetch";
      description = "Command executed when opening a shell session.";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.enable = true;

    home.shellAliases = {
      wf = ", bunx workforge-cli";
      opencode = ", bunx opencode-ai@latest";
      docker-nuke = "docker system prune -a --volumes";
      nixgc = "sudo nix-collect-garbage -d";
      nixprune = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2";

      ts = "task status";
      ta = "task add";

      k9sh = "k9s --kubeconfig=/home/garo/.kube/config-homelab";
      k9sw = "k9s --kubeconfig=/home/garo/.kube/config-work";

      helmh = "helm --kubeconfig ~/.kube/config-homelab";
      helmfileh = "helmfile --kubeconfig ~/.kube/config-homelab";

      kh = "kubectl --kubeconfig=/home/garo/.kube/config-homelab";
      kw = "kubectl --kubeconfig=/home/garo/.kube/config-work";
      k = "kubectl";

      v = "nvim";

      ydp = ''yt-dlp -i -f best -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" --extract-audio --audio-format mp3 --embed-metadata --parse-metadata "artist:%(uploader)s" --parse-metadata "album:%(playlist_title)s"'';
      yds = ''yt-dlp -i -f best -o "%(title)s.%(ext)s" --extract-audio --audio-format mp3 --embed-metadata --parse-metadata "artist:%(uploader)s" --parse-metadata "album:%(title)s"'';

      config = "/usr/bin/git --git-dir=$HOME/Dotfiles.git/ --work-tree=$HOME";
      gitg = "git log --oneline --decorate --graph --all --parents";

      red = "redshift -O 4100";
      dog = "bat";
      compose = "setxkbmap -layout us -option compose:menu";
      grep = "grep --color=auto";
      cp = "cp -i";
      mv = "mv -i";

      free = "free -m";
      crypto = "curl -s rate.sx";
      price = "curl -s rate.sx/doge |awk 'NR==34'";
      zcash = "curl -s rate.sx/zcash";
      btc = "curl -s rate.sx/btc";
      gpu = "nvidia-smi | sed -n '10p' | boxes -d stone -p a2v1 | lolcat -f";
      status = "gpu";
      rice = "curl -L rum.sh/ricebowl";
      moon = "curl wttr.in/moon";
      weather = "curl --silent wttr.in | head -n 6";
      coffee = "curl -L git.io/coffee ";
    } // lib.optionalAttrs (cfg.nixSwitchCommand != null) {
      nixs = cfg.nixSwitchCommand;
    };

    programs.nushell = {
      enable = lib.mkDefault true;
      settings = {
        show_banner = false;
      };
      extraConfig = lib.optionalString (cfg.startupCommand != null) ''
        ${cfg.startupCommand}
      '';
    };
  };
}
