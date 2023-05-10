class VLCControlsConstants {
  static String togglePlayPause = "command=pl_pause";
  static String playPrevious = "command=pl_previous";
  static String playNext = "command=pl_next";
  static String playStop = "command=pl_stop";

  // static String seekForward = "command=seek&val=";
  // static String seekRewind = "command=seek&val=";

  static String toggleFullScreen = "command=fullscreen";
  static String toggleLoopNRepeat = "command=key&val=loop";
  static String toggleShuffle = "command=key&val=random";
  static String toggleSubtitle = "command=key&val=subtitle-track";

  static String seekControl(String value){
    return "command=seek&val=$value";
  }

static String seekForward(double currentTime){
    currentTime = currentTime + 5;
    currentTime = (currentTime >= 512) ? 512 : currentTime;
    return "command=seek&val=${currentTime.toInt()}";
  }

  static String seekRewind(double currentTime){
    currentTime = currentTime - 5;
    currentTime = (currentTime <= 0) ? 0 : currentTime;
    return "command=seek&val=${currentTime.toInt()}";
  }

  //static String volumeControl = "command=volume&val=";

  static String volumeControl(String value){
    return "command=volume&val=$value";
  }

  static String increaseVolume(double currentVolume){
    currentVolume = currentVolume + 25.6;
    currentVolume = (currentVolume >= 512) ? 512 : currentVolume;
    return "command=volume&val=$currentVolume";
  }

  static String decreaseVolume(double currentVolume){
    currentVolume = currentVolume - 25.6;
    currentVolume = (currentVolume <= 0) ? 0 : currentVolume;
    return "command=volume&val=$currentVolume";
  }

  static String muteVolume = "command=key&val=vol-mute";


  static String toggleCrop = "command=key&val=crop";
  static String toggleAspectRatio = "command=key&val=aspect-ratio";
  static String takeScreenshot = "command=key&val=snapshot";


  static String subtitleDelayDown = "command=key&val=subdelay-down";
  static String subtitleDelayUp = "command=key&val=subdelay-up";
  static String audioTrackDelayDown = "command=key&val=audiodelay-down";
  static String toggleAudioTrack = "command=key&val=audio-track";
  static String audioTrackDelayUp = "command=key&val=audiodelay-up";

  static String playbackSpeedSlower = "command=key&val=slower";
  static String playbackSpeedFaster = "command=key&val=faster";
  static String cycleAudioDevices = "command=key&val=audiodevice-cycle";

  static String playbackSpeedFineFaster = "command=rate&val=";
  static String playbackSpeedFineSlower = "command=rate&val=";

  static String dvdControlMenu = "command=key&val=disc-menu";
  static String dvdControlOK = "command=key&val=nav-activate";
  static String dvdControlUp = "command=key&val=nav-up";
  static String dvdControlDown = "command=key&val=nav-down";
  static String dvdControlLeft = "command=key&val=nav-left";
  static String dvdControlRight = "command=key&val=nav-right";
  static String dvdControlTitlePrevious = "command=key&val=title-prev";
  static String dvdControlTitleNext = "command=key&val=title-next";
  static String dvdControlChapterPrevious = "command=key&val=chapter-prev";
  static String dvdControlChapterNext = "command=key&val=chapter-next";

  static String quitVLC = "command=key&val=quit";
}
