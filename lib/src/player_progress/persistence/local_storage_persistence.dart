// An implementation of [PlayerProgressPersistence] that uses
//  `package:shared_oreference`

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplegame/src/player_progress/persistence/player_progress.dart';

class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();
  @override
  Future<int> getHighestLevelReached() async {
    final prefs = await instanceFuture;
    return prefs.getInt('highestLevelReached') ?? 0;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    final prefs = await instanceFuture;
    await prefs.setInt('highestLevelReached', level);
  }
}
