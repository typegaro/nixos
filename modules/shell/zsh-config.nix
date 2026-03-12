{ config, lib, ... }:
let
  cfg = config."zsh-config";
  sharedShellCfg = config."shell-general";
in
{
  options."zsh-config" = {
    enable = lib.mkEnableOption "Enable custom zsh config";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

        shellAliases = {
          # ls (eza)
          ll = "eza --icons -al --color=always --group-directories-first";
          la = "eza --icons -a --color=always --group-directories-first";
          ls = "eza --icons -l --color=always --group-directories-first ";
          lt = "eza --icons -aT --color=always --group-directories-first -L 2";
          ltf = "eza --icons -aT --color=always --group-directories-first -L 100";

          ccp="CLAUDE_CONFIG_DIR=~/.claude-personal claude";
          ccw= "CLAUDE_CONFIG_DIR=~/.claude-work claude";
          ocw="OPENCODE_CONFIG_DIR=\"$HOME/.config/opencode-work/\" , opencode";
          ocp="OPENCODE_CONFIG_DIR=\"$HOME/.config/opencode-personal/\" , opencode";

          nixclean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
        };

      history = {
        size = 10000;
        save = 10000;
      };

      sessionVariables = {
        TERM = "xterm-256color";
        TERMINAL = "ghostty";
        EDITOR = "nvim";
      };

      initContent = ''
        autoload -U colors && colors
        PS1="%{$fg[magenta]%}%~%b λ "
        ${lib.optionalString (sharedShellCfg.enable && sharedShellCfg.startupCommand != null) sharedShellCfg.startupCommand}
        eval "$(direnv hook zsh)"
      '';
    };
  };
}
