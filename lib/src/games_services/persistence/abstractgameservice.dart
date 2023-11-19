import '../score.dart';

abstract class AbstractGameService {
  Future<void> awardAchievement({required String iOS, required String android});
  Future<void> initialize();
  Future<void> showAchievement();
  Future<void> showLeaderboard();
  Future<void> submitLeaderboardScore(Score score);
}
