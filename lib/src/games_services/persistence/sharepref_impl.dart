import 'dart:async';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../score.dart';
import 'abstractgameservice.dart';

class SharedPrefGamesServicesControllerImpl extends AbstractGameService {
  static final Logger _log = Logger('GamesServiesController');
  final Completer<bool> _signedInCompleter = Completer();
  
  @override
  Future<bool> get signedIn => _signedInCompleter.future;

  SharedPreferences? _prefs;
  String? _iOS;
  String? _android;

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<void> awardAchievement({
    required String iOS,
    required String android,
  }) async {
    _iOS = iOS;
    _android = _android;
    if (!await signedIn) {
      _log.warning("Trying to award achievement when not logged in.");
      return;
    }

    // Update achievement status in SharedPreferences
    await _initPrefs();
    _prefs?.setBool('$iOS-achievement', true);
    _prefs?.setBool('$android-achievement', true);
  }

  @override
  Future<void> initialize() async {
    try {
      // Simulate signing in
      await Future.delayed(const Duration(seconds: 2));

      // Update signedIn status in SharedPreferences
      await _initPrefs();
      _prefs?.setBool('signedIn', true);

      _signedInCompleter.complete(true);
    } catch (e) {
      _log.severe('Cannot log into GamesServices: $e');
      _signedInCompleter.complete(false);
    }
  }

  @override
  Future<void> showAchievement() async {
    if (!await signedIn) {
      _log.severe('Trying to show achievement when not logged in.');
      return;
    }

    // Retrieve achievement status from SharedPreferences
    await _initPrefs();
    bool iOSSuccess = _prefs?.getBool('$_iOS-achievement') ?? false;
    bool androidSuccess = _prefs?.getBool('$_android-achievement') ?? false;

    if (iOSSuccess || androidSuccess) {
      _log.info('Show achievements UI');
    } else {
      _log.warning('No achievements unlocked');
    }
  }

  // Implement other methods similarly...

  // Add fake leaderboards
  @override
  Future<void> showLeaderboard() async {
    if (!await signedIn) {
      _log.severe('Trying to show leaderboard when not logged in.');
      return;
    }

    _log.info('Show leaderboards UI');
  }

  @override
  Future<void> submitLeaderboardScore(Score score) async {
    if (!await signedIn) {
      _log.warning('Trying to submit leaderboard when not logged in.');
      return;
    }
    _log.info('Submitting $score to leaderboard.');
  }
}
