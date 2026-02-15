{ lib, config, pkgs, ... }:

{
  options.gitConfig.enable = lib.mkEnableOption "Git configuration";

  config = lib.mkIf config.gitConfig.enable {
    home.packages = [ pkgs.git pkgs.difftastic ];

    programs.git = {
      enable = true;
      userName = "typegaro";
      userEmail = "lorenzo.di.giovanni00@gmail.com";
      aliases = {
        s = "status";
        au = "add -u";
        cvn = "commit -m\"very nice\"";
      };
      extraConfig = {
        diff.external = "difft";
        diff.tool = "nvimdiff";
        merge.tool = "nvimdiff";
        mergetool.keepBackup = false;
        difftool.nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        mergetool.nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$BASE\" \"$REMOTE\" \"$MERGED\" -c 'wincmd J | wincmd ='";
      };
    };
  };
}
