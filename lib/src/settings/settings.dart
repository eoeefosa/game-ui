import 'package:flutter/foundation.dart';
import 'package:simplegame/src/settings/persistence/settings_persistence.dart';

class SettingsController {
  /// Whether or not the sound is on at all. This overrides both music and sound.
  ValueNotifier<bool> muted = ValueNotifier(false);
  ValueNotifier<String> playerName = ValueNotifier('New Player');
  ValueNotifier<bool> soundsOn = ValueNotifier(false);
  ValueNotifier<bool> musicOn = ValueNotifier(false);  

  /// Creates a new instance of [SettingsController] backed by [persistence].
  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  final SettingsPersistence _persistence;

  /// Asynchronously loads values from the injected persistence store.
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
