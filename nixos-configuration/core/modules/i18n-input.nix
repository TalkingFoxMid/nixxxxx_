{ config, pkgs, lib, ... }:
{
  # Enable Fcitx5 input method for Chinese pinyin support
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-configtool
      fcitx5-gtk
    ];
  };

  # Set environment variables for proper input method integration
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus"; # For apps using GLFW
  };

  # Add related packages
  environment.systemPackages = with pkgs; [
    # Optional - Chinese fonts
    wqy_zenhei
    wqy_microhei
    noto-fonts-cjk-sans
  ];
}
