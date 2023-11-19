import 'dart:async';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'abstractgameservice.dart';

class GamesServicesControllerImpl extends AbstractGameService {
  static final Logger _log = Logger('GamesServiesController');
  final Completer<bool> _signedInCompleter = Completer();
  Future<bool> get signedIn => _signedInCompleter.future;

  SharedPreferences? _prefs;

  Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  @override
  Future<void> awardAchievement({
    required String iOS,
    required String android,
  }) async {
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
      await Future.delayed(Duration(seconds: 2));

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
    bool iOSSuccess = _prefs?.getBool('$iOS-achievement') ?? false;
    bool androidSuccess = _prefs?.getBool('$android-achievement') ?? false;

    if (iOSSuccess || androidSuccess) {
      _log.info('Show achievements UI');
    } else {
      _log.warning('No achievements unlocked');
    }
  }

  // Implement other methods similarly...

  // Add fake leaderboards
  Future<void> showLeaderboard() async {
    if (!await signedIn) {
      _log.severe('Trying to show leaderboard when not logged in.');
      return;
    }

    _log.info('Show leaderboards UI');
  }

  Future<void> submitLeaderboardScore(Score score) async {
    if (!await signedIn) {
      _log.warning('Trying to submit leaderboard when not logged in.');
      return;
    }
    _log.info('Submitting $score to leaderboard.');
  }
}
