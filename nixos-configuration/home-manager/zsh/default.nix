{ users, config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      neofetch
      
      # Function to check if we're inside a distrobox container
      # and modify the prompt accordingly
      function container_prompt_info() {
        if [[ -n "$CONTAINER_ID" ]]; then
          echo "%F{yellow}[%F{red}📦 %F{green}$CONTAINER_ID%F{yellow}]%f "
        fi
      }
      
      # Add container indicator to the prompt
      export PROMPT='$(container_prompt_info)'$PROMPT
    '';
    
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      rebuild = "~/nix-state/scripts/rebuild";
      nixed = "~/nix-state/scripts/nixed";
      cls = "clear";
    };

    # Enable Oh My Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "kubectl"
        "sudo"
        "history"
        "extract"
        "dirhistory"
      ];
      theme = "agnoster";
    };

    # Add plugins from external sources
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
      name = "zsh-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "0.7.1";
        sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
      };
    }
    ];
  };
}