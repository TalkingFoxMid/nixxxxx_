{ users, config, pkgs, lib, ... }:

let
  claudeCode = pkgs.callPackage ./package.nix {};
in
{
  home.packages = with pkgs; [
    claudeCode
  ];
  
  # Add Claude Code to PATH
  home.sessionPath = [ "${claudeCode}/bin" ];
}
