{ config, pkgs, ... }:

{
  home.username = "vasilis";
  home.homeDirectory = "/home/vasilis";
  home.stateVersion = "25.11"; # DO NOT CHANGE

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    DOCKER_HOST = "unix:///run/user/1000/docker.sock";
  };

  home.packages = with pkgs; [
    ncdu
    gping
    duf
    octave
    slack
    typst
    nodejs
    verible
    verilator
    fastfetch
    czkawka
    nixfmt
    nerd-fonts.fira-code
    nerd-fonts.ubuntu-mono
    cmake
    gns3-gui
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
    ssh-agent.enable = true;
    #    podman.enable = true;
  };

  programs = {
    # Allow home-manager to manage itself
    home-manager.enable = true;

    # Git
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
    lazygit.enable = true;
    gh.enable = true;

    # Shell
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
    zsh.enable = true;
    fzf.enable = true;
    bat.enable = true;
    htop.enable = true;
    eza.enable = true;
    btop.enable = true;
    neovim.enable = true;
    fd.enable = true;
    #    lazydocker.enable = true;
    man.enable = true;

    # GUI
    vesktop.enable = true;
    vscode.enable = true;
    onlyoffice.enable = true; # TODO: this isnt very good in kubuntu
    obsidian.enable = true;
    obsidian.vaults."Vault".target = "Documents/Vault";

    # Programming
    go.enable = true;
    npm.enable = true;
    cargo.enable = true;
    uv.enable = true;
  };

  home.file.".config/starship.toml".source = ./starship.toml;
}
