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
      minimizeToTray = false;
      tray = false;
      splashBackground = "#000000";
      splashColor = "#ffffff";
      splashTheming = true;
      staticTitle = true;
      hardwareAcceleration = true;
      discordBranch = "stable";
    };

    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = false;
      useQuickCss = true;
      disableMinSize = true;

      plugins = {
        BetterGifAltText.enabled = true;
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
        PinDMs.enabled = true;
        ReadAllNotificationsButton.enabled = true;
        RelationshipNotifier.enabled = true;
        ServerListIndicators = {
          enabled = true;
          mode = myLib.bitShiftLeft 1 0; # only servers
        };
        SilentTyping.enabled = true;
        SpotifyControls.enabled = true;
        SpotifyCrack.enabled = true;
        Translate.enabled = true;
        TypingIndicator.enabled = true;
        UserMessagesPronouns.enabled = true;
        USRBG.enabled = true;
        WebKeybinds.enabled = true;
        WebScreenShareFixes.enabled = true;
        YoutubeAdblock.enabled = true;
      };
    };
  };
}
