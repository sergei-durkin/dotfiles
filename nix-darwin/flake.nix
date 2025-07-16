{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {
      environment.systemPackages =
        [
          pkgs.bottom
          pkgs.silver-searcher
          pkgs.gdu
          pkgs.mkalias
          pkgs.alacritty
          pkgs.tmux
          pkgs.starship
          pkgs.zoxide
          pkgs.ripgrep
          pkgs.fd
          pkgs.bat
          pkgs.fzf
          pkgs.lazygit
          pkgs.atuin
          pkgs.eza
          pkgs.btop
          pkgs.direnv
          pkgs.fastfetch
          pkgs.k9s
          pkgs.cowsay
          pkgs.tree
          pkgs.delve
          pkgs.gitmux
        ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      # fonts.packages = [
      #   pkgs.nerdfonts.JetBrainsMono
      # ];

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;  # default shell on catalina
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
