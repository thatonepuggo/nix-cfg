{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.myHome.browser;
in {
  options.myHome.browser = {
    enable = mkEnableOption "a web browser";
  };

  config = {
    programs.floorp = mkIf (cfg.enable) {
      enable = true;
      profiles."user" = {
        id = 0;
        isDefault = true;

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          nekocap
          bitwarden
          (frankerfacez.override {meta.license = lib.licenses.asl20;})
          sponsorblock
          stylus
          ublock-origin
          violentmonkey
          reddit-enhancement-suite
        ];

        bookmarks = {
          settings = let
            mkBookmark = name: url: {inherit name url;};
            mkKeyword = name: keyword: url: {inherit name keyword url;};
            mkFolder = name: bookmarks: {inherit name bookmarks;};
            mkToolbar = bookmarks: {
              inherit bookmarks;
              toolbar = true;
            };
          in [
            (mkToolbar [
              (mkBookmark "YouTube" "https://youtube.com")

              (mkFolder "nix resources" [
                (mkKeyword
                  "nixos packages"
                  "nixpkgs"
                  "https://search.nixos.org/packages?channel=unstable&query=%s")
                (mkKeyword
                  "nixos options"
                  "nixopts"
                  "https://search.nixos.org/options?channel=unstable&query=%s")
                (mkBookmark "hm opts" "https://nix-community.github.io/home-manager/options.xhtml")
                (mkBookmark "explainix" "https://zaynetro.com/explainix")
              ])
            ])
          ];
          force = true;
        };

        search = {
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };

            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@hm"];
            };
          };

          default = "ddg";
          force = true;
        };

        settings = let
          smoothScrollDuration = 50;
        in {
          # dont show again
          "app.normandy.first_run" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.warnOnClose" = false;

          # newtab
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

          # chrome
          "floorp.browser.workspaces.enabled" = false;
          "floorp.browser.sidebar.enable" = false;
          "browser.bookmarks.addedImportButton" = false;
          "browser.urlbar.scotchBonnet.enableOverride" = true;

          # extensions
          "extensions.autoDisableScopes" = 0;

          # password manager
          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;

          # behavior
          "general.smoothScroll.lines.durationMaxMS" = smoothScrollDuration;
          "general.smoothScroll.lines.durationMinMS" = smoothScrollDuration;
          "general.smoothScroll.mouseWheel.durationMaxMS" = smoothScrollDuration;
          "general.smoothScroll.mouseWheel.durationMinMS" = smoothScrollDuration;
          "general.smoothScroll.other.durationMaxMS" = smoothScrollDuration;
          "general.smoothScroll.other.durationMinMS" = smoothScrollDuration;
          "general.smoothScroll.pixels.durationMaxMS" = smoothScrollDuration;
          "general.smoothScroll.pixels.durationMinMS" = smoothScrollDuration;
          "general.smoothScroll.pages.durationMaxMS" = smoothScrollDuration;
          "general.smoothScroll.pages.durationMinMS" = smoothScrollDuration;
          "general.smoothScroll.scrollbars.durationMaxMS" = smoothScrollDuration;
          "general.smoothScroll.scrollbars.durationMinMS" = smoothScrollDuration;
        };

        userChrome = ''
          @-moz-document url(chrome://browser/content/browser.xhtml) {
            /* -100/10 ux */
            toolbarbutton#undo-closed-tab,
            toolbarbutton#sidebar-reverse-position-toolbar,
            toolbarbutton#sidebar-button,
            toolbarbutton#firefox-view-button,

            /* accounts */
            toolbarbutton#profile-manager,

            /* titlebar buttons */
            hbox.titlebar-spacer[type="post-tabs"],
            hbox.titlebar-buttonbox-container {
              display: none !important;
            }
          }
        '';
      };
      policies = {
        ExtensionSettings = {
          "*".installation_mode = "allowed";
        };
      };
    };

    stylix.targets.floorp.profileNames = ["user"];
  };
}
