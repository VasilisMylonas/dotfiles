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
    scrcpy
    clang
    clang-tools
    cmake
    rustup
    postgresql
    yosys
    iverilog
    iperf3
    nmap
    traceroute
    ngspice
    ncdu
    gping
    duf
    octave # NOTE: this is terminal only version
    typst
    verible
    verilator
    fastfetch
    nixfmt
    nerd-fonts.fira-code
    nerd-fonts.ubuntu-mono
    cmake
    # GUI
#    virt-manager NOTE: prefer native package
#    virt-viewer
    gns3-gui
    slack
    x2goclient
    czkawka
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
#    podman.enable = true; # NOTE: Prefer docker (native install)
  };

  programs = {
    # Allow home-manager to manage itself
    home-manager.enable = true;

    # Terminal
    ssh = {
      enable = true;
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
        grep = "grep --color=auto";
        tree = "eza --tree";
        vim = "nvim";
        neofetch = "fastfetch";

	# TODO: maybe these should be removed
        cat = "bat --style=plain --paging=never";
        top = "btop";
        ping = "gping";
        df = "duf";
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
    man.enable = true;
    go.enable = true;
    npm.enable = true;
#    cargo.enable = true; # NOTE: use rustup on pkgs
    uv.enable = true;
    direnv = {
    	enable = true;
	enableBashIntegration = true;
	enableZshIntegration = true;
    };
    claude-code.enable = true;

    # GUI: NOTE: integration may not be as good as native
    vesktop.enable = true;
#    vscode.enable = true;
    #onlyoffice.enable = true; # NOTE: this isnt very good in kubuntu
    obsidian.enable = true;
    obsidian.vaults."Vault".target = "Documents/Vault";
  };

  home.file.".config/starship.toml".source = ./starship.toml;
}
