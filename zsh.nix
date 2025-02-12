{ config, pkgs, ... }:{
  home = {
    username = "user";
    homeDirectory = "/Users/user";
    stateVersion = "24.11";
    packages = with pkgs; [
      colima
      direnv
      docker
      gh
      jq
      kind
      krew
      kubectl
      stern
      zsh
    ];
  };
  programs = {
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        nix_shell = {
          disabled = false;
          heuristic = true;
        };
        kubernetes = {
          disabled = false;
        };
      };
    };
    zsh = {
      enable = true;

      initExtraFirst = ''
      '';
      initExtra = ''
        export PATH="$HOME/.krew/bin:$PATH"
        ZPLUG_PATH=$(nix eval --raw .#homeConfigurations.user.pkgs.zplug) && export PATH=$(echo ":$PATH:" | sed -E "s#:$ZPLUG_PATH/share/zplug/bin*##g")
      '';
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-completions"; }
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "zsh-users/zsh-syntax-highlighting"; }
          { name = "plugins/colored-man-pages"; tags = [from:oh-my-zsh]; }
          { name = "plugins/kubectl"; tags = [from:oh-my-zsh]; }
          { name = "plugins/direnv"; tags = [from:oh-my-zsh]; }
        ]; 
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
    };
    autojump.enable = true;
    fzf.enable = true;
  };
}
