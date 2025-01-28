{ config, pkgs, ... }:{
  home = {
    username = "user";
    homeDirectory = "/Users/user";
    stateVersion = "22.11";
    packages = with pkgs; [
      colima
      direnv
      docker
      krew
      kubectl
      kind
      1password
    ];
  };
  programs = {ki
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        nix_shell = {
          disabled = false;
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
      '';
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "zsh-users/zsh-syntax-highlighting"; }
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
