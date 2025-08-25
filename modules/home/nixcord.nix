{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.myHome.nixcord;
in {
  options = {
    myHome.nixcord = {
      enable = lib.mkEnableOption "nixcord";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      vesktop.enable = true;
      discord.enable = false;

      quickCss = ''
        .theme-light, .theme-dark, .theme-darker, .theme-midnight, .visual-refresh {
          --background-message-highlight: var(--base02) !important;
        }
      '';

      config = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = true;
        disableMinSize = true;

        plugins = {
          betterGifAltText.enable = true;
          betterRoleDot.enable = true;
          betterSettings.enable = true;
          callTimer.enable = true;
          consoleJanitor.enable = true;
          decor.enable = true;
          fakeNitro = {
            enable = true;
            transformEmojis = true;
          };
          favoriteGifSearch.enable = true;
          fixSpotifyEmbeds.enable = true;
          gifPaste.enable = true;
          messageLogger.enable = true;
          mutualGroupDMs.enable = true;
          #oneko.enable = true;
          permissionsViewer.enable = true;
          pinDMs.enable = true;
          readAllNotificationsButton.enable = true;
          #relationshipNotifier.enable = true;
          reviewDB.enable = true;
          serverListIndicators = {
            enable = true;
            mode = "onlyServerCount";
          };
          silentTyping.enable = true;
          spotifyControls.enable = true;
          spotifyCrack.enable = true;
          summaries.enable = true;
          translate.enable = true;
          typingIndicator.enable = true;
          userMessagesPronouns.enable = true;
          USRBG.enable = true;
          validReply.enable = true;
          validUser.enable = true;
          volumeBooster.enable = true;
          webKeybinds.enable = true;
          webScreenShareFixes.enable = true;
          whoReacted.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };
  };
}
