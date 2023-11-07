import 'package:simplegame/src/settings/persistence/settings_persistence.dart';

/// An in-memory implementation of [SettingsPersistence].
/// Useful for testing

class MemoryOnlySettingsPersistence implements SettingsPersistence {
  bool musicOn = true;
  bool soundOn = true;
  bool muted = false;
  String playerName = 'New Player';

  @override
  Future<bool> getMusicOn() async => musicOn;

  @override
  Future<bool> getMuted({required bool defaultValue}) async => muted;

  @override
  Future<String> getPlayerName() async => playerName;

  @override
  Future<bool> getSoundsOn() async => soundOn;

  @override
  Future<void> saveMusicOn(bool value) async => musicOn = value;

  @override
  Future<void> saveMuted(bool value) async => muted = value;

  @override
  Future<void> savePlayerName(String value) async => playerName = value;

  @override
  Future<void> saveSoundOn(bool value) async => soundOn = value;
}
