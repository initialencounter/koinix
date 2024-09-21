{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = {
    self, nixpkgs, flake-utils
  }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
  in rec {
    packages._update = pkgs.substituteAll {
      src = ./update.sh;
      dir = "/bin";
      isExecutable = true;
      inherit (pkgs) runtimeShell;
      path = pkgs.lib.makeBinPath (with pkgs; [
        prefetch-npm-deps nodejs
      ]);
    };
    lib.buildKoishi = config: pkgs.callPackage ./src { inherit config; };
    packages.default = lib.buildKoishi {
      host = "0.0.0.0";
      port = 8080;
      plugins = {
        adapter-onebot = {
          selfId = "*";
          endpoint = "ws://*:*";
          token = "*";
          protocol = "ws";
        };
        minesweeper-ending = {
          theme = "wom";
        };
        help-pro = {};
        cube = {};
        "@initencounter/koishi-plugin-jimp" = {};
        puzzle = {};
        furbot = {};
        status-image = {};
        sleep-manage = {};
        cron = {};
        gh-tile = {};
        status-pro = {
          botName = "小真寻";
          command = "机机状态";
        };
        couplet = {};
        davinci-003 = {
          baseURL = "https://api.chatanywhere.com.cn";
          key = "key-*";
        };
        ichess = {};
        config = {};
        admin = {};
        bind = {};
        commands = {};
        inspect = {};
        locales = {};
        rate-limit = {};
        analytics = {};
        console = {};
        dataview = {};
        explorer = {};
        logger = {};
        auth.admin.password = "114514";
        insight = {};
        sandbox = {};
        database-sqlite = {};
        assets-local = {};
        puppeteer = {};
        screenshot = {};
        echo = {};
      };
    };
  });
}