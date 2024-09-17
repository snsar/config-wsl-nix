# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "snsar";
  

  # Cài đặt và cấu hình Zsh
  programs.zsh = {
    enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      upgrade = "sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";
    };
    autosuggestions.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "eastwood";
    syntaxHighlighting.enable = true;
  };

  # Đặt Zsh làm shell mặc định cho người dùng mới
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    zsh
    oh-my-zsh
    wget
    git
    stow
    zoxide
    fzf
    fnm
    thefuck
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
