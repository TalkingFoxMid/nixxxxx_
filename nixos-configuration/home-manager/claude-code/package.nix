{ lib, buildNpmPackage, fetchurl, nodejs, makeWrapper, writeShellScriptBin }:

let
  # Main package
  claudeCode = buildNpmPackage rec {
    pname = "claude-code";
    version = "0.2.29";

    src = fetchurl {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
      hash = "sha256-1iKDtTE+cHXMW/3zxfsNFjMGMxJlIBzGEXWtTfQfSMM=";
    };

    npmDepsHash = "sha256-tMuBd6rNb0Wz/zAe6yAcqQ84M7lAt+VlqoycG7dKYO0=";

    inherit nodejs;

    makeCacheWritable = true;
    forceEmptyCache = true;

    postPatch = ''
      echo "Creating minimal package-lock.json"
      cat > package-lock.json << EOF
    {
      "name": "@anthropic-ai/claude-code",
      "version": "${version}",
      "lockfileVersion": 3,
      "requires": true,
      "packages": {
        "": {
          "name": "@anthropic-ai/claude-code",
          "version": "${version}"
        }
      }
    }
    EOF
    '';

    dontNpmBuild = true;
    dontNpmInstall = true;

    nativeBuildInputs = [ makeWrapper ];

    # Create a custom installation phase to handle the package organization
    installPhase = ''
      # Create a directory for the lib files
      mkdir -p $out/lib/node_modules/@anthropic-ai/claude-code

      # Copy all package files to the lib directory
      cp -a . $out/lib/node_modules/@anthropic-ai/claude-code/

      # Create bin directory
      mkdir -p $out/bin

      # Create a wrapper script that points to the actual CLI script
      makeWrapper ${nodejs}/bin/node $out/bin/claude-code \
        --add-flags "$out/lib/node_modules/@anthropic-ai/claude-code/cli.mjs"
    '';

    meta = with lib; {
      description = "Claude Code CLI tool";
      homepage = "https://www.anthropic.com/claude-code";
      mainProgram = "claude-code";
    };
  };

  # Helper script to update the package-lock.json file
  updateScript = writeShellScriptBin "update-claude-code-lock" ''
    #!/usr/bin/env bash
    # Update script implementation would go here
    echo "Update script not implemented in this integration"
  '';
in
  # Return both the package and the update script
  claudeCode // {
    updateScript = updateScript;
    passthru = (claudeCode.passthru or {}) // {
      inherit updateScript;
    };
  }