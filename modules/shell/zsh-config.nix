{ config, lib, pkgs, ... }:

{
  options."zsh-config".enable = lib.mkEnableOption "Enable custom zsh config";

  config = lib.mkIf config."zsh-config".enable {
    # Assicura XDG per la history path
    xdg.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        size = 10000;
        save = 10000;
      };

      sessionVariables = {
        TERM = "xterm-256color";
        TERMINAL = "ghostty";
      };

      shellAliases = {
        wf = "~/Prj/workforge/bin/wf";
        docker-nuke = "docker system prune -a --volumes";
        # ls (eza)
        ll = "eza --icons -al --color=always --group-directories-first";
        la = "eza --icons -a --color=always --group-directories-first";
        ls = "eza --icons -l --color=always --group-directories-first ";
        lt = "eza --icons -aT --color=always --group-directories-first -L 2";
        ltf = "eza --icons -aT --color=always --group-directories-first -L 100";

        # update (NixOS)
        nixs= "sudo nixos-rebuild switch --flake ~/Nix";
        nixgc = "sudo nix-collect-garbage -d";

        # task
        ts = "task status";
        ta = "task add";

        # python
        psource = "source prjenv/bin/activate";

        # k9s
        k9sh = "k9s --kubeconfig=/home/garo/.kube/config-homelab";
        k9sw = "k9s --kubeconfig=/home/garo/.kube/config-work";

        # helm
        helmh = "helm --kubeconfig ~/.kube/config-homelab";
        helmfileh = "helmfile --kubeconfig ~/.kube/config-homelab";

        # kubectl
        kh = "kubectl --kubeconfig=/home/garo/.kube/config-homelab";
        kw = "kubectl --kubeconfig=/home/garo/.kube/config-work";
        k = "kubectl";

        # nvim
        v = "nvim";

        # yt-dlp
        ydp = ''yt-dlp -i -f best -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s" --extract-audio --audio-format mp3 --embed-metadata --parse-metadata "artist:%(uploader)s" --parse-metadata "album:%(playlist_title)s"'';
        yds = ''yt-dlp -i -f best -o "%(title)s.%(ext)s" --extract-audio --audio-format mp3 --embed-metadata --parse-metadata "artist:%(uploader)s" --parse-metadata "album:%(title)s"'';

        # git
        config = "/usr/bin/git --git-dir=$HOME/Dotfiles.git/ --work-tree=$HOME";
        gitg = "git log --oneline --decorate --graph --all --parents";

        # redshift
        red = "redshift -O 4100";

        # cat
        dog = "bat";

        # shortcuts
        compose = "setxkbmap -layout us -option compose:menu";

        # grep
        grep = "grep --color=auto";

        # conferme
        cp = "cp -i";
        mv = "mv -i";

        # info
        free = "free -m";
        crypto = "curl -s rate.sx";
        price = "curl -s rate.sx/doge |awk 'NR==34'";
        zcash= "curl -s rate.sx/zcash";
        btc = "curl -s rate.sx/btc";
        cpu = "ps ax -o cmd,%cpu --sort=-%cpu | head ";
        ram = "ps ax -o cmd,%mem --sort=-%mem | head ";
        gpu = "nvidia-smi | sed -n '10p' | boxes -d stone -p a2v1 | lolcat -f";
        status = "cpu;gpu;ram";
        rice = "curl -L rum.sh/ricebowl";
        moon = "curl wttr.in/moon";
        weather = "curl --silent wttr.in | head -n 6";
        coffee = "curl -L git.io/coffee ";
      };

      initContent = ''
        # colori + prompt
        autoload -U colors && colors
        PS1="%{$fg[magenta]%}%~%b λ "
        neofetch
      '';
    };
  };
}
