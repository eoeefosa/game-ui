List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.huhsh:
      return const [
        'sfx/hash1.mp3',
        'sfx/hash2.mp3',
        'sfx/hash3.mp3',
      ];
    case SfxType.wssh:
      return const [
        'sfx/wssh1.mp3',
        'sfx/wssh2.mp3',
        'sfx/dsht1.mp3',
        'sfx/ws1.mp3',
        'sfx/spsh1.mp3',
        'sfx/hh1.mp3',
        'sfx/hh2.mp3',
        'sfx/kss1.mp3',
      ];
    case SfxType.buttonTap:
      return const [
        'sfx/k1.mp3',
        'sfx/k2.mp3',
        'sfx/p1.mp3',
        'sfx/p2.mp3',
      ];
    case SfxType.congrats:
      return const [
        'sfx/yay1.mp3',
        'sfx/wehee1.mp3',
        'sfx/oo1.mp3',
      ];
    case SfxType.erase:
      return const [
        'sfx/fwfwfwfwfw1.mp3',
        'sfx/fwfwfwfw1.mp3',
      ];
    case SfxType.swishSwish:
      return const [
        'sfx/swishswish1.mp3',
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
