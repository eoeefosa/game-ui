import 'package:simplegame/src/player_progress/persistence/player_progress.dart';

/// An in-memory implementation oƒ [PLayerProgressPersistence].
/// Usefull for testing

class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
  int level = 0;
  @override
  Future<int> getHighestLevelReached() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return level;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    this.level = level;
  }
}
