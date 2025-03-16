{config, pkgs, lib, ...}:
{
  nixpkgs.config.permittedInsecurePackages = ["electron-32.3.3"];

  nixpkgs.overlays = [
    (final: prev: {
      obsidian-wayland = prev.obsidian.override {electron = final.electron_32;};
    })
  ];

  environment.systemPackages = with pkgs; [
    obsidian-wayland
  ];
}
