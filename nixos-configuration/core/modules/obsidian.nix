{config, pkgs, lib, ...}:
{
  nixpkgs.config.permittedInsecurePackages = ["electron-24.8.6"];

  nixpkgs.overlays = [
    (final: prev: {
      obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
    })
  ];

  environment.systemPackages = with pkgs; [
    obsidian-wayland
  ];
}
