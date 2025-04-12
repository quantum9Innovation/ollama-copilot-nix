{
  description = "ollama-copilot go package flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        srcInfo = builtins.fromJSON (builtins.readFile ./sourcing.json);
        ollama-copilot = pkgs.buildGoModule {
          pname = "ollama-copilot";
          version = "unstable-${builtins.substring 0 8 srcInfo.rev}";

          src = pkgs.fetchFromGitHub {
            owner = "bernardo-bruning";
            repo = "ollama-copilot";
            rev = srcInfo.rev;
            sha256 = srcInfo.hash;
          };

          vendorHash = "sha256-g27MqS3qk67sve/jexd07zZVLR+aZOslXrXKjk9BWtk=";
          subPackages = [ "." ];
        };
      in {
        packages.default = ollama-copilot;
      });
}
