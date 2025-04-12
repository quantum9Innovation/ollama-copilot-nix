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

        ollama-copilot = pkgs.buildGoModule {
          pname = "ollama-copilot";
          version = "unstable-2025-04-12";

          src = pkgs.fetchFromGitHub {
            owner = "bernardo-bruning";
            repo = "ollama-copilot";
            rev = "d049c48e103f75a00c2bed66cedaee6e1dd89fb0";
            sha256 = "sha256-mWbE5NwGHgbNDrZ/0BQn4tySRi5JU76iMTNKZAtMAxg=";
          };

          vendorHash = "sha256-g27MqS3qk67sve/jexd07zZVLR+aZOslXrXKjk9BWtk=";

          subPackages = [ "." ];
        };
      in {
        packages.default = ollama-copilot;
      });
}
