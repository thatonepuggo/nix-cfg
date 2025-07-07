{
  config,
  pkgs,
  myLib,
  ...
}: {
  programs.vesktop = {
    enable = true;

    settings = {
      appBadge = false;
      arRPC = true;
      checkUpdates = false;
      customTitleBar = false;
      disableMinSize = true;
      discordBranch = "stable";
      hardwareAcceleration = true;
      minimizeToTray = false;
      roleDot = true;
      splashBackground = "#000000";
      splashColor = "#ffffff";
      splashTheming = true;
      staticTitle = true;
      tray = false;
    };

    vencord = {
      settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = true;
        disableMinSize = true;

        plugins = {
          BetterGifAltText.enabled = true;
          BetterRoleDot.enabled = true;
          BetterSettings.enabled = true;
          CallTimer.enabled = true;
          ConsoleJanitor.enabled = true;
          Decor.enabled = true;
          FakeNitro = {
            enabled = true;
            transformEmojis = true;
          };
          FavoriteGifSearch.enabled = true;
          FixSpotifyEmbeds.enabled = true;
          GifPaste.enabled = true;
          MessageLogger.enabled = true;
          MutualGroupDMs.enabled = true;
          oneko.enabled = true;
          PermissionsViewer.enabled = true;
          PinDMs.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          RelationshipNotifier.enabled = true;
          ReviewDB.enabled = true;
          ServerListIndicators = {
            enabled = true;
            mode = myLib.bitShiftLeft 1 0; # only servers
          };
          SilentTyping.enabled = true;
          SpotifyControls.enabled = true;
          SpotifyCrack.enabled = true;
          Summaries.enabled = true;
          Translate.enabled = true;
          TypingIndicator.enabled = true;
          UserMessagesPronouns.enabled = true;
          USRBG.enabled = true;
          ValidReply.enabled = true;
          ValidUser.enabled = true;
          VolumeBooster.enabled = true;
          WebKeybinds.enabled = true;
          WebScreenShareFixes.enabled = true;
          WhoReacted.enabled = true;
          YoutubeAdblock.enabled = true;
        };
      };
    };
  };
}
