import 'dart:async';

import 'package:games_services/games_services.dart' as gs;
import 'package:logging/logging.dart';
import 'package:simplegame/src/games_services/persistence/abstractgameservice.dart';
import 'package:simplegame/src/games_services/score.dart';

class GamesServicesControllerImpl extends AbstractGameService {
  static final Logger _log = Logger('GamesServiesController');
  final Completer<bool> _signedIncompleter = Completer();
  Future<bool> get signedIn => _signedIncompleter.future;

  /// Unlocks an achievement on Game Center / Play Games.
  ///
  /// You must provide the achievement ids via the [iOS] and [android]
  /// parameters.
  ///
  /// Does nothing when the game isn't signed into the underlying
  /// games service.
  @override
  Future<void> awardAchievement(
      {required String iOS, required String android}) async {
    if (!await signedIn) {
      _log.warning("Trying to award achievement when not logged in.");
      return;
    }
    try {
      await gs.GamesServices.unlock(
        achievement: gs.Achievement(
          androidID: android,
          iOSID: iOS,
        ),
      );
    } catch (e) {
      _log.severe('Cannot award achievement: $e');
    }
  }

  @override
  Future<void> initialize() async {
    try {
      await gs.GamesServices.signIn();

      // The API is unclear so we're checking to be sure. The above call
      // returns a String, not a boolean, and there's no documentation
      // as to whether every non-error result means we're safely signed in.
      final signedIn = await gs.GamesServices.isSignedIn;
      _signedIncompleter.complete(signedIn);
    } catch (e) {
      _log.severe('Cannot log into GamesServices:$e');
      _signedIncompleter.complete(false);
    }
  }
  /// Launches the platform's UI overlay with achievements.
  @override
  Future<void> showAchievement() async {
    if (!await signedIn) {
      _log.severe('Trying to show achievement when not logged in.');
      return;
    }

    try {
      // returns a string
      await gs.GamesServices.showAchievements();
    } catch (e) {
      _log.severe('Cannot show achievements: $e');
    }
  }

  /// Launches the platform's UI overlay with leaderboard(s).
  @override
  Future<void> showLeaderboard() async {
    if (!await signedIn) {
      _log.severe('Trying to show leaderboard when not logged in');
      return;
    }
    try {
      await gs.GamesServices.showLeaderboards(
        // TODO: When ready, change both these leaderboard IDs.
        iOSLeaderboardID: "some_id_from_app_store",
        androidLeaderboardID: "sOmE_iD_fRoM_gPlAy",
      );
    } catch (e) {
      _log.severe('Cannot show Leaderboard: $e');
    }
  }

  /// Submits [score] to the leaderboard.
  @override
  Future<void> submitLeaderboardScore(Score score) async {
    if (!await signedIn) {
      _log.warning('Trying to submit leaderboard when not logged in.');
      return;
    }
    _log.info('Submitting $score to leaderboard.');
    try {
      await gs.GamesServices.submitScore(
          score: gs.Score(
        // TODO: When ready, change these leaderboard IDs.
        iOSLeaderboardID: 'some_id_from_app_store',
        androidLeaderboardID: 'sOmE_iD_fRoM_gPlAy',
      ));
    } catch (e) {
      _log.severe('Cannot submit leaderboard score: $e');
    }
  }
}
