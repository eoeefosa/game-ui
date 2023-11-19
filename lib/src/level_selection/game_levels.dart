const gamelevels = [
  GameLevel(
    number: 1,
    difficulty: 5,
     // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: "firstwin",
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: "firstwee",
  ),
  GameLevel(
    number: 2,
    difficulty: 42,
    // achievementIdIOS: "firstwin",
    // achievementIdAndroid: "firstwee",
  ),
  GameLevel(
    number: 3,
    difficulty: 100,
    achievementIdIOS: "finished",
    achievementIdAndroid: "finished",
  )
];

class GameLevel {
  const GameLevel({
    required this.number,
    required this.difficulty,
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');

  final int number;
  final int difficulty;

  /// The achievement to unlock when the level is finished, if any.
  final String? achievementIdIOS;
  final String? achievementIdAndroid;
  // check if android has achievement
  bool get awardsAchievement => achievementIdAndroid != null;
}
