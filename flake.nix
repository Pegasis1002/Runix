{
  description = "RISC-V 32-bit Embedded Development Environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      # This is the "Magic" line: it tells Nix to provide the 
      # RISC-V cross-compiler instead of the standard x86 one.
      pkgs = import nixpkgs {
        inherit system;
        crossSystem = {
          config = "riscv32-none-elf";
          # Use 'rv32i' or 'rv32imc' depending on your specific RTL core
          gcc.arch = "rv32imac"; 
          gcc.abi = "ilp32";
        };
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.buildPackages.gcc
          pkgs.buildPackages.binutils
          pkgs.buildPackages.gdb
        ];

        shellHook = ''
          echo "領域展開 // DOMAIN EXPANSION: RISC-V Silicon Forge"
          riscv32-none-elf-gcc --version
        '';
      };
    };
}
