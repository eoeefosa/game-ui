// import 'dart:collection';
// import 'dart:math';

// import 'package:flutter/widgets.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:logging/logging.dart';

// import '../settings/settings.dart';
// import 'songs.dart';
// import 'sounds.dart';

// class AudioController {
//   static final _log = Logger('AudioController');

//   late final AudioPlayer _musicPlayer;
//   late AudioPlayer _sfxPlayer;

//   final List<AudioPlayer> _sfxPlayers;

//   final int _currentSfxPlayer = 0;

//   final Queue<Song> _playlist;

//   final Random _random = Random();

//   SettingsController? _settings;

//   ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

//   AudioController({int polyphony = 2})
//       : assert(polyphony >= 1),
//         _musicPlayer = AudioPlayer(),
//         _sfxPlayers = List.generate(
//           polyphony,
//           (i) => AudioPlayer(),
//         ),
//         _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
//     _initializePlayers();

//     _musicPlayer.playerStateStream.listen(_handleMusicPlayerStateChange);
//   }

//   void _initializePlayers() {
//     _musicPlayer.setUrl(_playlist.first.filename, preload: true);

//     _sfxPlayer = _sfxPlayers.first;
//   }

//   void attachLifecycleNotifier(
//       ValueNotifier<AppLifecycleState> lifecycleNotifier) {
//     _lifecycleNotifier?.removeListener(_handleAppLifecycle);

//     lifecycleNotifier.addListener(_handleAppLifecycle);
//     _lifecycleNotifier = lifecycleNotifier;
//   }

//   void attachSettings(SettingsController settingsController) {
//     if (_settings == settingsController) {
//       return;
//     }

//     final oldSettings = _settings;
//     if (oldSettings != null) {
//       oldSettings.muted.removeListener(_mutedHandler);
//       oldSettings.musicOn.removeListener(_musicOnHandler);
//       oldSettings.soundsOn.removeListener(_soundsOnHandler);
//     }

//     _settings = settingsController;

//     settingsController.muted.addListener(_mutedHandler);
//     settingsController.musicOn.addListener(_musicOnHandler);
//     settingsController.soundsOn.addListener(_soundsOnHandler);

//     if (!settingsController.muted.value && settingsController.musicOn.value) {
//       _startMusic();
//     }
//   }

//   void dispose() {
//     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
//     _stopAllSound();
//     _musicPlayer.dispose();
//     for (final player in _sfxPlayers) {
//       player.dispose();
//     }
//   }

//   Future<void> initialize() async {
//     _log.info('Preloading sound effects');
//     // Preload sound effects if necessary
//   }

//   void playSfx(SfxType type) {
//     final muted = _settings?.muted.value ?? true;
//     if (muted) {
//       _log.info(() => 'Ignoring playing sound ($type) because audio is muted.');
//       return;
//     }
//     final soundsOn = _settings?.soundsOn.value ?? false;
//     if (!soundsOn) {
//       _log.info(() =>
//           'Ignoring playing sound ($type) because sounds are turned off.');
//       return;
//     }

//     _log.info(() => 'Playing sound: $type');
//     final options = soundTypeToFilename(type);
//     final filename = options[_random.nextInt(options.length)];
//     _log.info(() => '- Chosen filename: $filename');
//     _sfxPlayer.setUrl(filename);
//     _sfxPlayer.play();
//   }

//   void _handleMusicPlayerStateChange(PlayerState state) {
//     if (state == PlayerState.completed) {
//       _changeSong();
//     }
//   }

//   void _changeSong() {
//     _log.info('Last song finished playing.');

//     _playlist.addLast(_playlist.removeFirst());

//     _log.info(() => 'Playing ${_playlist.first} now.');
//     _musicPlayer.setUrl(_playlist.first.filename);
//     _musicPlayer.play();
//   }

//   void _handleAppLifecycle() {
//     switch (_lifecycleNotifier!.value) {
//       case AppLifecycleState.paused:
//       case AppLifecycleState.detached:
//         _stopAllSound();
//         break;
//       case AppLifecycleState.resumed:
//         if (!_settings!.muted.value && _settings!.musicOn.value) {
//           _resumeMusic();
//         }
//         break;
//       case AppLifecycleState.inactive:
//         // Handle inactive state if necessary
//         break;
//     }
//   }

//   void _musicOnHandler() {
//     if (_settings!.musicOn.value) {
//       if (!_settings!.muted.value) {
//         _resumeMusic();
//       }
//     } else {
//       _stopMusic();
//     }
//   }

//   void _mutedHandler() {
//     if (_settings!.muted.value) {
//       _stopAllSound();
//     } else {
//       if (_settings!.musicOn.value) {
//         _resumeMusic();
//       }
//     }
//   }

//   void _resumeMusic() {
//     _log.info('Resuming music');
//     if (_musicPlayer.playerState.value == PlayerState.paused) {
//       _musicPlayer.play();
//     } else if (_musicPlayer.playerState.value == PlayerState.stopped) {
//       _musicPlayer.setUrl(_playlist.first.filename);
//       _musicPlayer.play();
//     }
//   }

//   void _soundsOnHandler() {
//     for (final player in _sfxPlayers) {
//       if (player.playerState.value == PlayerState.playing) {
//         player.stop();
//       }
//     }
//   }

//   void _startMusic() {
//     _log.info('Starting music');
//     _musicPlayer.play();
//   }

//   void _stopAllSound() {
//     if (_musicPlayer.playerState.value == PlayerState.playing) {
//       _musicPlayer.pause();
//     }
//     for (final player in _sfxPlayers) {
//       if (player.playerState.value == PlayerState.playing) {
//         player.stop();
//       }
//     }
//   }

//   void _stopMusic() {
//     _log.info('Stopping music');
//     if (_musicPlayer.playerState.value == PlayerState.playing) {
//       _musicPlayer.pause();
//     }
//   }
// }
