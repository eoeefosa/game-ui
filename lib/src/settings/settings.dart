import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simplegame/src/settings/persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;
// TODO: CHANGE THIS TO TRUE BECOUSE WHEN IT IS MUTED SOUND AND MUSIC ARE FALSE
  ValueNotifier<bool> muted = ValueNotifier(false);
  ValueNotifier<String> playerName = ValueNotifier('New Player');
  ValueNotifier<bool> soundsOn = ValueNotifier(false);
  ValueNotifier<bool> musicOn = ValueNotifier(false);

  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      // if its web getmuted is false
      _persistence
          .getMuted(defaultValue: kIsWeb)
          .then((value) => muted.value = value),
      _persistence.getSoundsOn().then((value) => soundsOn.value = value),
      _persistence.getMusicOn().then((value) => musicOn.value = value),
      _persistence.getPlayerName().then((value) => playerName.value = value),
    ]);
  }

  void setPlayerName(String name) {
    playerName.value = name;
    _persistence.savePlayerName(playerName.value);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _persistence.saveMusicOn(musicOn.value);
  }

  void toggleMuted() {
    muted.value = !muted.value;
    _persistence.saveMuted(muted.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _persistence.saveSoundOn(soundsOn.value);
  }
}
