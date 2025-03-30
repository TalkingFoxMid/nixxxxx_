{users, config, pkgs, ...}:
{
  # Install anki and some useful add-ons
  home.packages = with pkgs; [
    anki-bin  # Use the binary distribution which has better performance
    
    # Dependencies that might be useful for anki add-ons
    python3
    python3Packages.requests
    python3Packages.beautifulsoup4
    python3Packages.pip
    python3Packages.pillow  # For image handling
  ];
}
