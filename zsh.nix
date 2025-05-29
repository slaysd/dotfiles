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
      uv
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
      # case insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      '';
      initExtra = ''
        export PATH=$HOME/.krew/bin:$PATH
        export ZPLUG_HOME=$HOME/.zplug
        source $ZPLUG_HOME/init.zsh
        
        # Zplug
        zplug check || zplug install
        if ! zplug check --verbose; then
          printf "Install? [y/N]: "
          if read -q; then
            echo; zplug install
          fi
        fi
        zplug "zsh-users/zsh-completions"
        zplug "zsh-users/zsh-autosuggestions"
        zplug "zsh-users/zsh-syntax-highlighting"
        zplug "plugins/colored-man-pages", from:oh-my-zsh
        zplug "plugins/kubectl", from:oh-my-zsh
        zplug "plugins/direnv", from:oh-my-zsh
        zplug load
      '';
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
    };
    autojump.enable = true;
    fzf.enable = true;
  };
}
