{ config, pkgs, ... }:

{
  home.username = "vasilis";
  home.homeDirectory = "/home/vasilis";
  home.stateVersion = "25.11"; # DO NOT CHANGE

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
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
#       nerd-fonts.fira-code
      nerd-fonts.ubuntu-mono
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
    git.enable = true;
    git.signing.format = "ssh";
    git.signing.key = "~/.ssh/id_ed25519_github.pub";
    git.signing.signByDefault = true;
    git.settings.user.email = "vasilismylonas@protonmail.com";
    git.settings.user.name = "Vasilis Mylonas";
    lazygit.enable = true;
    gh.enable = true;

    # Shell
    starship.enable = true;
    starship.enableZshIntegration = true;
    starship.enableBashIntegration = true;
    bash.enable = true;
    bash.enableCompletion = true;
    bash.shellAliases = {
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
#    bash.bashrcExtra = ''
#export DOCKER_HOST=unix:///run/user/1000/docker.sock
#'';
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
    uv.enable = true;

    # GUI
    vesktop.enable = true;
    vscode.enable = true;
    onlyoffice.enable = true; # TODO: this isnt very good in kubuntu
    obsidian.enable = true;
    obsidian.vaults."Vault".target = "Documents/Vault";

    # Programming
    go.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file.".config/starship.toml".text = ''
format = """
[](#9A348E)\
$os\
$username\
[](bg:#DA627D fg:#9A348E)\
$directory\
[](fg:#DA627D bg:#FCA17D)\
$git_branch\
$git_status\
[](fg:#FCA17D bg:#86BBD8)\
$c\
$elixir\
$elm\
$golang\
$gradle\
$haskell\
$java\
$julia\
$nodejs\
$nim\
$rust\
$scala\
[](fg:#86BBD8 bg:#06969A)\
$docker_context\
[](fg:#06969A bg:#33658A)\
$time\
[ ](fg:#33658A)\
"""

# Disable the blank line at the start of the prompt
# add_newline = false

# You can also replace your username with a neat symbol like   or disable this
# and use the os module below
[username]
show_always = true
style_user = "bg:#9A348E"
style_root = "bg:#9A348E"
format = '[$user ]($style)'
disabled = false

# An alternative to the username module which displays a symbol that
# represents the current operating system
[os]
style = "bg:#9A348E"
disabled = true # Disabled by default

[directory]
style = "bg:#DA627D"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

# Here is how you can shorten some long paths by text replacement
# similar to mapped_locations in Oh My Posh:
[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "
# Keep in mind that the order matters. For example:
# "Important Documents" = " 󰈙 "
# will not be replaced, because "Documents" was already substituted before.
# So either put "Important Documents" before "Documents" or use the substituted version:
# "Important 󰈙 " = " 󰈙 "

[c]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[docker_context]
symbol = " "
style = "bg:#06969A"
format = '[ $symbol $context ]($style)'

[elixir]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[elm]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[git_branch]
symbol = ""
style = "bg:#FCA17D"
format = '[ $symbol $branch ]($style)'

[git_status]
style = "bg:#FCA17D"
format = '[$all_status$ahead_behind ]($style)'

[golang]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[gradle]
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[haskell]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[java]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[julia]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[nodejs]
symbol = ""
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[nim]
symbol = "󰆥 "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[rust]
symbol = ""
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[scala]
symbol = " "
style = "bg:#86BBD8"
format = '[ $symbol ($version) ]($style)'

[time]
disabled = false
time_format = "%R" # Hour:Minute Format
style = "bg:#33658A"
format = '[ $time ]($style)'
	'';
}
