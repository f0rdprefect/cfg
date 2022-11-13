# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      #./home-manager
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-09f669d1-5ada-480f-8b7d-8dea7d1dc4cc".device = "/dev/disk/by-uuid/09f669d1-5ada-480f-8b7d-8dea7d1dc4cc";
  boot.initrd.luks.devices."luks-09f669d1-5ada-480f-8b7d-8dea7d1dc4cc".keyFile = "/crypto_keyfile.bin";
  boot.kernelPackages = pkgs.linuxPackages_zen; 


  networking.hostName = "cw-0262"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matt = {
    isNormalUser = true;
    description = "matt";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vim
      firefox
    #  thunderbird
    ];
    #shell="/usr/bin/zsh";
    openssh.authorizedKeys.keys = [
      
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDtkdsMIF3pQw4oLv+7ShT3UtHexFxzx/mEz/cIAPXvTxhRK6UMYu7Ku7ioeFibnSPKxk9d095W192jbIPoriFLkpiHbDqmfJ3I/X6xPhkFxknxRFSHm5GCOzY9Q4Gt+ObpuJOGOsLtXcQ0Ug/icXVijAbfAyOGwgWljl1Nf8W4b7qBMpzQMbSwZqGV7JN7lvWafVh4vLAi/smPcd9fD7MC5oGo7rmRsYMGbvRN2h/W5g/UvRMd3bk24FPpd8scFoLrVJBXWV7KSIIrCCK084mGG2PhAkegX0doewyIjfnpAcbVge2X5ujB9z0UcSXXp1U/zwHAzD24WbAdoIogs76d matt"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
        
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    fzf 
    fd
    ripgrep
    gitFull
    espanso
    caffeine-ng #needs tweak
    neovim
    oh-my-zsh
    zsh
    gnumake    
    powertop
    home-manager
    #
    vifm
    tmux
    kitty
    alacritty
    #
    python310
    inkscape
    gimp
    imagemagick
    freeplane
    libreoffice-fresh
    nomacs
    pandoc
    sphinx
    texlive.combined.scheme-full 
    #
    rofi
    rofi-pass
    rofi-rbw
    haskellPackages.greenclip
    #
    bitwarden
    bitwarden-cli
    pass
    #
    hamster
    citrix_workspace_22_05_0
    teams
    teamviewer
    klayout
    #browser
    firefox
    falkon
    chromium
    microsoft-edge
    #
    # The following is a Qt theme engine, which can be configured with kvantummanager
    libsForQt5.qtstyleplugin-kvantum
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp = {
          enable = true;
          settings = {
             START_CHARGE_THRESH_BAT0=42; 
             STOP_CHARGE_THRESH_BAT0=80;
          } ; 
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
