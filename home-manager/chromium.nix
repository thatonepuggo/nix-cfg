{
  config,
  pkgs,
  ...
}: {
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    commandLineArgs = [
      "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
      "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
      "--enable-features=UseMultiPlaneFormatForHardwareVideo"
      "--enable-zero-copy"
      "--enable-logging=stderr"
      "--ignore-gpu-blocklist"
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
    ];
    extensions = [
      {id = "ddkjiahejlhfcafbddmgiahcphecmpfh";} # ublock origin lite
      {id = "gmopgnhbhiniibbiilmbjilcmgaocokj";} # nekocap
      {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      {id = "fadndhdgpmmaapbmfcknlfgcflmmmieb";} # frankerfacez
      {id = "jgejdcdoeeabklepnkdbglgccjpdgpmf";} # old twitter layout
      {id = "kbmfpngjjgdllneeigpgjifpgocmfgmb";} # reddit enhancement suite
    ];
  };
}
