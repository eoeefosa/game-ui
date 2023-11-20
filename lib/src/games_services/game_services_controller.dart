import 'package:simplegame/src/games_services/persistence/abstractgameservice.dart';

import 'score.dart';
// TODO: USING SETTINGS AND GAMESERVICE CREATE THIS CONTROLLER

class GameServicesController {
  const GameServicesController(
      {required AbstractGameService gamesServiceController})
      : _gameServicecontroller = gamesServiceController;
  final AbstractGameService _gameServicecontroller;

  Future<bool> get signedIn => _gameServicecontroller.signedIn;
  Future<void> awardAchievement(
      {required String iOS, required String android}) async {
    await _gameServicecontroller.awardAchievement(iOS: iOS, android: android);
  }

  Future<void> initialize() async {
    await _gameServicecontroller.initialize();
  }

  Future<void> showAchievement() async {
    await _gameServicecontroller.showAchievement();
  }

  Future<void> showLeaderboard() async {
    await _gameServicecontroller.showLeaderboard();
  }

  Future<void> submitLeaderboardScore(Score score) async {
    await _gameServicecontroller.submitLeaderboardScore(score);
  }
}
