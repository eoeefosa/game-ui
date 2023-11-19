import 'dart:collection';
import 'dart:math';
// import 'package:audioplayers/audioplayers.dart' hide Logger;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:simplegame/src/audio/songs.dart';
import 'package:simplegame/src/audio/sounds.dart';
import 'package:simplegame/src/settings/settings.dart';

class AudioController {
  static final _log = Logger('AudioController');

  late final AudioPlayer _musicPlayer;
  late AudioPlayer _sfxPlayer;

  final List<AudioPlayer> _sfxPlayers;

  final int _currentSfxPlayer = 0;
  final Queue<Song> _playlist;

  final Random _random = Random();

  SettingsController? _settings;

  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  AudioController({int polyphony = 2})
      : assert(polyphony >= 1),
        _musicPlayer = AudioPlayer(),
        _sfxPlayers = Iterable.generate(polyphony, (i) => AudioPlayer())
            .toList(growable: false),
        _playlist = Queue.of(
          List<Song>.of(songs)..shuffle(),
        ) {
    _initializePlayers();
    _musicPlayer.playerStateStream.listen(_changeSong);
  }
  void _initializePlayers() {
    _musicPlayer.setUrl(_playlist.first.filename, preload: true);

    _sfxPlayer = _sfxPlayers.first;
  }

  void attachLifecycleNotifier(
      ValueNotifier<AppLifecycleState> lifecycleNotifier) {
    // Remove previous ValueNotifier<AppLifecycleState>
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);

    // Add a new ValueNotifier<AppLifecycleState>
    lifecycleNotifier.addListener(_handleAppLifecycle);
    //dispose of the previous lifecyleNotifier
    _lifecycleNotifier = lifecycleNotifier;
  }

  void attachSettings(SettingsController settingsController) {
    if (_settings == settingsController) {
      return;
    }
    final oldSettings = _settings;
    // Remove handlers from the old settings controller if present
    if (oldSettings != null) {
      oldSettings.muted.removeListener(_mutedHandler);
      oldSettings.musicOn.removeListener(_musicOnHandler);
      oldSettings.soundsOn.removeListener(_soundOnHandler);
    }
    _settings = settingsController;

    settingsController.muted.addListener(_mutedHandler);
    settingsController.musicOn.addListener(_musicOnHandler);
    settingsController.soundsOn.addListener(_soundOnHandler);

    if (!settingsController.muted.value && settingsController.musicOn.value) {
      _startMusic();
    }
  }

  void dispose() async {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _stopAllSound();
    await _musicPlayer.dispose();
    for (final players in _sfxPlayers) {
      await players.dispose();
    }
  }

  Future<void> initialize() async {
    _log.info('Preloading sound effects');
  }

  void playSfx(SfxType type) async {
    final muted = _settings?.muted.value ?? true;
    if (muted) {
      _log.info(() => 'Ignoring playing sound($type) because audio is muted. ');
      return;
    }
    final soundOn = _settings?.soundsOn.value ?? false;

    if (!soundOn) {
      _log.info(
          () => 'Ignoring playing sound($type) because sounds are turned off.');
      return;
    }

    _log.info(() => 'Playing sound: $type');
    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];
    _log.info(() => '- Chosen filename: $filename');
    await _sfxPlayer.setUrl(filename);
    _sfxPlayer.play();
  }

  void _changeSong(void _) async {
    _log.info('Last song finished playing.');
    // Put the song that just finished playing to the end of the playlist.
    _playlist.addLast(_playlist.removeFirst());
    // Play the next song.
    _log.info(() => 'Playing ${_playlist.first} now.');
    await _musicPlayer.setUrl(_playlist.first.filename);
  }

  void _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _stopAllSound();
        break;
      case AppLifecycleState.resumed:
        if (!_settings!.muted.value && _settings!.musicOn.value) {
          _resumeMusic();
        }
        break;
      case AppLifecycleState.inactive:
        // No need to react to this state change.
        break;
    }
  }

  void _musicOnHandler() {
    if (_settings!.musicOn.value) {
      // Music got turned on.
      if (!_settings!.muted.value) {
        _resumeMusic();
      }
    } else {
      // Music got turned off.
      _stopMusic();
    }
  }

  void _mutedHandler() {
    if (_settings!.muted.value) {
      // All sound just got muted.
      _stopAllSound();
    } else {
      // All sound just got un-muted.
      if (_settings!.musicOn.value) {
        _resumeMusic();
      }
    }
  }

  Future<void> _resumeMusic() async {
    _log.info("Resuming music");
    switch (_musicPlayer.playerState.playing) {
      // case PlayerState.paused:
      //   _log.info('Calling _musicPlayer.resume()');
      //   try {
      //     await _musicPlayer.resume();
      //   } catch (e) {
      //     _log.severe(e);
      //     await _musicPlayer.play(AssetSource(_playlist.first.filename));
      //   }
      //   break;
      // case PlayerState.stopped:
      //   _log.info("resumeMusic() called when music is stopped. "
      //       "This probably means we haven't yet started the music. "
      //       "For example, the game was started with sound off.");
      //   await _musicPlayer.play(AssetSource(_playlist.first.filename));

      //   break;
      // case PlayerState.playing:
      //   _log.warning('resumeMusic() called when music is playing. '
      //       'Nothing to do.');
      //   break;

      // case PlayerState.completed:
      //   _log.warning('resumeMusic() called when music is completed. '
      //       "Music should never be 'completed' as it's either not playing "
      //       "or looping forever.");
      //   await _musicPlayer.play(AssetSource(_playlist.first.filename));
      //   break;
      // case PlayerState.disposed:
      //   break;
      case true:
        _log.warning('resumeMusic() called when music is playing. '
            'Nothing to do.');
        // _musicPlayer.play();
        break;
      case false:
        _log.warning('resumeMusic() called when music is completed. '
            "Music should never be 'completed' as it's either not playing "
            "or looping forever.");
        await _musicPlayer.setUrl(_playlist.first.filename);
        _musicPlayer.play();
        break;
    }
  }

  void _soundOnHandler() {
    for (final player in _sfxPlayers) {
      if (player.playerState.playing) {
        player.stop();
      }
    }
  }

  void _startMusic() {
    _log.info('starting music');
    // _musicPlayer.play(_playlist.first.filename);
    _musicPlayer.play();
  }

  void _stopAllSound() async {
    if (_musicPlayer.playerState.playing) {
      await _musicPlayer.pause();
    }
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }

  void _stopMusic() async {
    _log.info('Stopping music');
    if (_musicPlayer.playerState.playing) {
      await _musicPlayer.pause();
    }
  }
}
