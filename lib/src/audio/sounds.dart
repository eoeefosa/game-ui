List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.huhsh:
      return const [
        'hash1.mp3',
        'hash2.mp3',
        'hash3.mp3',
      ];
    case SfxType.wssh:
      return const [
        'assets/sfx/wssh1.mp3',
        'assets/sfx/wssh2.mp3',
        'assets/sfx/dsht1.mp3',
        'assets/sfx/ws1.mp3',
        'assets/sfx/spsh1.mp3',
        'assets/sfx/hh1.mp3',
        'assets/sfx/hh2.mp3',
        'assets/sfx/kss1.mp3',
      ];
    case SfxType.buttonTap:
      return const [
        'assets/sfx/k1.mp3',
        'assets/sfx/k2.mp3',
        'assets/sfx/p1.mp3',
        'assets/sfx/p2.mp3',
      ];
    case SfxType.congrats:
      return const [
        'assets/sfx/yay1.mp3',
        'assets/sfx/wehee1.mp3',
        'assets/sfx/oo1.mp3',
      ];
    case SfxType.erase:
      return const [
        'assets/sfx/fwfwfwfwfw1.mp3',
        'assets/sfx/fwfwfwfw1.mp3',
      ];
    case SfxType.swishSwish:
      return const [
        'assets/sfx/swishswish1.mp3',
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.huhsh:
      return 0.4;
    case SfxType.wssh:
      return 0.2;
    case SfxType.buttonTap:
    case SfxType.congrats:
    case SfxType.erase:
    case SfxType.swishSwish:
      return 1.0;
  }
}

enum SfxType {
  huhsh,
  wssh,
  buttonTap,
  congrats,
  erase,
  swishSwish,
}
