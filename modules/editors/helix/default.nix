{ pkgs, ...}:
{
    programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "onedark";
      editor = {
        auto-format = false;
        line-number = "relative";
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
        };

        whitespace.render.tab = "all";
        indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 1;
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };

      keys.normal = {
        C-s = ":w";
      };
      keys.insert = {
        j.j = "normal_mode";
      };
    };
  };

  home.packages = with pkgs; [
    # clojure-lsp
    # cmake-language-server
    # libclang # for c/c++
    # dart
    # dockerfile-language-server-nodejs
    # elixir-ls
    # fortls # fortran
    gopls # for go lang
    # haskell-language-server
    # jdt-language-server # for java
    nodePackages_latest.typescript-language-server # for java/typescript
    # julia
    # kotlin-language-server
    # texlab # for latex
    # lean4
    lua-language-server
    marksman # for markdown
    nil # for nix
    # ols # for odin
    # perlnavigator # for perl
    # python311Packages.python-lsp-server
    # R # R
    # rust-analyzer
    # sourcekit-lsp # for swift
    # taplo # for toml
    # vlang
    # vala-language-server
    # nodePackages_latest.vls # for vue
    vscode-langservers-extracted # for html/css
    # yaml-language-server
    # zls # for zig
  ];
}

