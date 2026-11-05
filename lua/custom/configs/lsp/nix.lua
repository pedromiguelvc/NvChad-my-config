return {
  nixd = {
    filetypes = { "nix" },
    settings = {
      nixd = {
        nixpkgs = {
          expr = 'import (builtins.getFlake "/home/carburauto/nixos").inputs.nixpkgs { }',
        },
        options = {
          nixos = {
            expr = '(builtins.getFlake "/home/carburauto/nixos").nixosConfigurations.carburauto.options',
          },
          home_manager = {
            expr = '(builtins.getFlake "/home/carburauto/nixos").nixosConfigurations.carburauto.options.home-manager.users.type.getSubOptions []',
          },
        },
      },
    },
  },
}
