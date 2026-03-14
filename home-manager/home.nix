{ config, pkgs, ... }:

{
  home.username = "vasilis";
  home.homeDirectory = "/home/vasilis";
  home.stateVersion = "25.11"; # DO NOT CHANGE

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    DOCKER_HOST = "unix:///run/user/1000/docker.sock";
    ANTHROPIC_AUTH_TOKEN = "ollama";
    ANTHROPIC_API_KEY = "";
    ANTHROPIC_BASE_URL = "http://localhost:11434";
  };

  home.packages = with pkgs; [
    postgresql
    yosys
    iperf3
    nmap
    traceroute
    ngspice
    ncdu
    gping
    duf
    octave 
    typst
    verible
    verilator
    fastfetch
    czkawka
    nixfmt
    nerd-fonts.fira-code
    nerd-fonts.ubuntu-mono
    cmake
    # GUI
    virt-manager
    virt-viewer
    gns3-gui
    slack
  ];

  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
      settings = {
        devices."Laptop" = {
          id = "3GMURHO-GYYQS6P-HV5NKFW-TUHCPZL-PPW2FQ3-6YLGWCH-4ZTJPZB-GDBNAQ3";
        };
        folders."Sync" = {
          enable = true;
          id = "default";
          path = "~/Sync";
          devices = [ "Laptop" ];
        };
      };
    };
    ollama.enable = true;
    ssh-agent.enable = true;
#    podman.enable = true; # NOTE: Prefer docker (native install)
  };

  programs = {
    # Allow home-manager to manage itself
    home-manager.enable = true;
    
    # Terminal
    git = {
      enable = true;
      signing = {
        format = "ssh";
        key = "~/.ssh/id_ed25519_github.pub";
        signByDefault = true;
      };
      settings = {
        user.email = "vasilismylonas@protonmail.com";
        user.name = "Vasilis Mylonas";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "eza --color=auto --icons --group-directories-first";
        ll = "eza -lh --color=auto --icons --group-directories-first";
        la = "eza -lah --color=auto --icons --group-directories-first";
        cat = "bat --style=plain --paging=never";
        grep = "grep --color=auto";
        tree = "eza --tree";
        top = "btop";
        ping = "gping";
        df = "duf";
        vim = "nvim";
        neofetch = "fastfetch";
      };
    };
    lazygit.enable = true;
    gh.enable = true;
    zsh.enable = true;
    fzf.enable = true;
    bat.enable = true;
    htop.enable = true;
    eza.enable = true;
    btop.enable = true;
    neovim.enable = true;
    fd.enable = true;
    lazydocker.enable = true;

    # Programming
    man.enable = true;
    go.enable = true;
    npm.enable = true;
    cargo.enable = true;
    uv.enable = true;
    claude-code.enable = true;

    # GUI
    vesktop.enable = true;
    vscode.enable = true;
    #onlyoffice.enable = true; # NOTE: this isnt very good in kubuntu
    obsidian.enable = true;
    obsidian.vaults."Vault".target = "Documents/Vault";
  };

  home.file.".config/starship.toml".source = ./starship.toml;
}
