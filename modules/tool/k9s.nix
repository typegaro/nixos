{ lib, config, pkgs, ... }:

{
  options."k9s".enable = lib.mkEnableOption "K9s configuration with One Dark skin";

  config = lib.mkIf config."k9s".enable {
    xdg.enable = true;

    xdg.configFile = {
      "k9s/config.yaml".text = ''
        k9s:
          ui:
            skin: one_dark
      '';

      "k9s/skins/one_dark.yaml".text = ''
        k9s:
          body:
            fgColor: '#abb2bf'
            bgColor: '#282c34'
            logoColor: '#61afef'

          info:
            fgColor: '#abb2bf'
            sectionColor: '#61afef'

          frame:
            border:
              fgColor: '#61afef'
              focusColor: '#c678dd'

            menu:
              fgColor: '#abb2bf'
              keyColor: '#61afef'
              numKeyColor: '#e5c07b'

            crumbs:
              fgColor: '#282c34'
              bgColor: '#61afef'
              activeColor: '#c678dd'

            status:
              newColor: '#98c379'
              modifyColor: '#e5c07b'
              addColor: '#61afef'
              errorColor: '#e06c75'
              highlightColor: '#56b6c2'
              killColor: '#d19a66'
              completedColor: '#5c6370'

            title:
              fgColor: '#abb2bf'
              bgColor: '#282c34'
              highlightColor: '#61afef'
              counterColor: '#c678dd'
              filterColor: '#e5c07b'

          views:
            table:
              fgColor: '#abb2bf'
              bgColor: '#282c34'
              cursorColor: '#61afef'
              header:
                fgColor: '#abb2bf'
                bgColor: '#282c34'
                sorterColor: '#61afef'

            yaml:
              keyColor: '#61afef'
              colonColor: '#abb2bf'
              valueColor: '#98c379'

            logs:
              fgColor: '#abb2bf'
              bgColor: '#282c34'
      '';
    };
  };
}
