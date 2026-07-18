{ config, pkgs, ... }:

{
  home.username = "vasilis";
  home.homeDirectory = "/home/vasilis";
  home.stateVersion = "25.11"; # DO NOT CHANGE

  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    DOCKER_HOST = "unix:///run/user/1000/docker.sock";
  };

  home.packages = with pkgs; [
    #    scrcpy
    #    clang
    #    clang-tools
    #    cmake
    #    rustup
    #    postgresql
    #    yosys
    #    iverilog
    # verible
    # verilator
    #    traceroute
    #ngspice
    ncdu
    duf
    typst
    iperf3
    fastfetch
    nixfmt
    nerd-fonts.fira-code
    nerd-fonts.ubuntu-mono
  ];

  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
    };
    ssh-agent.enable = true;
  };

  programs = {
    # Allow home-manager to manage itself
    home-manager.enable = true;

    # Terminal
    ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "hpc" = {
          hostname = "scgroup3.ceid.upatras.gr";
          user = "hpcgrp29";
          forwardAgent = true;
        };
        "sisman" = {
          hostname = "150.140.141.66";
          user = "up1100643";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_rsa_stds";
          addKeysToAgent = "yes";
          forwardAgent = true;
        };
        "kamino" = {
          hostname = "kamino.ceid.upatras.gr";
          user = "vmylonas";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519_kamino";
          addKeysToAgent = "yes";
          forwardAgent = true;
        };
      };
    };
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
      enableBashIntegration = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "eza --color=auto --icons --group-directories-first";
        ll = "eza -lh --color=auto --icons --group-directories-first";
        la = "eza -lah --color=auto --icons --group-directories-first";
        grep = "grep --color=auto";
        tree = "eza --tree";
        vim = "nvim";
        neofetch = "fastfetch";
        cat = "bat --style=plain --paging=never";
        df = "duf";
      };
    };
    gh.enable = true;
    fzf.enable = true;
    bat.enable = true;
    htop.enable = true;
    eza.enable = true;
    neovim = {
    	enable = true;
	withRuby = true;
	withPython3 = true;
    };
    fd.enable = true;
    man.enable = true;
    #    go.enable = true;
    #    npm.enable = true;
    #    cargo.enable = true; # NOTE: use rustup on pkgs
    uv.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
    };
    claude-code.enable = true;
  };
  home.file.".config/starship.toml".source = ./starship.toml;
}
