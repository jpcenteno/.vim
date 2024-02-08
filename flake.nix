{
  description = "My personal Neovim configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells = rec {
        default = pkgs.mkShell {
          packages = with pkgs; [
            lua-language-server
            nodePackages.vim-language-server
          ];
        };
      };
    }
  );
}
