{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "matt";
  home.homeDirectory = "/home/matt";
  
  # raw configuration files
  home.file.".vimrc".source = ./vimrc;     
  home.file.".zshrc".source = ./zshrc;     

  programs.git = {
     enable = true;
     userName = "Matthias Berse";
     userEmail = "matthias.berse@raith.de";
     };
  # espanso
  #programs.espanso = {
  #   enable = true;
  #};
  home.file.".config/espanso" = {
       recursive = true;
       source = ./espanso;
   };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}

