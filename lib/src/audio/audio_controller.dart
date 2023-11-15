import 'dart:collection';
import 'dart:ffi';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:simplegame/src/audio/songs.dart';
import 'package:simplegame/src/audio/sounds.dart';
import 'package:simplegame/src/settings/settings.dart';

class AudioController {
  static final _log = Logger('AudioController');
  final AudioPlayer _musicPlayer;
  final List<AudioPlayer> _sfxPlayers;

  final int _currentSfxPlayer = 0;
  final Queue<Song> _playlist;

  final Random _random = Random();

  SettingsController? _settings;

  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  AudioController({int polyphony = 2})
      : assert(polyphony >= 1),
        _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
        _sfxPlayers = Iterable.generate(
            polyphony,
            (i) => AudioPlayer(
                  playerId: 'sfxPlayer#$i',
                )).toList(growable: false),
        _playlist = Queue.of(List<Song>.of(songs)..shuffle(),) {
    _musicPlayer.onPlayerStateChanged.listen(_changeSong);
  }


  void attachLifecycleNotifier(
      ValueNotifier<AppLifecycleState> lifecycleNotifier) {
    // Remove previous ValueNotifier<AppLifecycleState>
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);

    // Add a new ValueNotifier<AppLifecycleState>
    lifecycleNotifier.addListener(_handleAppLifecycle);
    //
    _lifecycleNotifier = lifecycleNotifier;
  }

  void attachSettings(SettingsController settingsController) {}
  void dispose() {}
  Future<void> initialize() async {}
  void playSfx(SfxType type) {

  }

  void _changeSong(void _) {
    _log.info('Last song finished playing.');
    _playlist.addLast(_playlist.removeFirst());
    _log.info(() => 'Playing ${_playlist.first} now.');
    _musicPlayer.play(AssetSource(_playlist.first.filename));
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
    switch (_musicPlayer.state) {
      case PlayerState.paused:
        _log.info('Calling _musicPlayer.resume()');
        try {
          await _musicPlayer.resume();
        } catch (e) {
          _log.severe(e);
          await _musicPlayer.play(AssetSource(_playlist.first.filename));
        }
        break;
      case PlayerState.stopped:
        _log.info("resumeMusic() called when music is stopped. "
            "This probably means we haven't yet started the music. "
            "For example, the game was started with sound off.");
        await _musicPlayer.play(AssetSource(_playlist.first.filename));

        break;
      case PlayerState.playing:
        _log.warning('resumeMusic() called when music is playing. '
            'Nothing to do.');
        break;

      case PlayerState.completed:
        _log.warning('resumeMusic() called when music is completed. '
            "Music should never be 'completed' as it's either not playing "
            "or looping forever.");
        await _musicPlayer.play(AssetSource(_playlist.first.filename));
        break;
      case PlayerState.disposed:
        break;
    }
  }

  void _soundOnHandler() {
    for (final player in _sfxPlayers) {
      if (player.state == PlayerState.playing) {
        player.stop();
      }
    }
  }

  void _startMusic() {
    _log.info('starting music');
    _musicPlayer.play(AssetSource(_playlist.first.filename));
  }

  void _stopAllSound() {
    if (_musicPlayer.state == PlayerState.playing) {
      _musicPlayer.pause();
    }
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }

  void _stopMusic() {
    _log.info('Stopping music');
    if (_musicPlayer.state == PlayerState.playing) {
      _musicPlayer.pause();
    }
  }
}
