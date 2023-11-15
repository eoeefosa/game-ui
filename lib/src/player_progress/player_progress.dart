import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:simplegame/src/player_progress/persistence/player_progress.dart';

class PlayerProgress extends ChangeNotifier {
  static const maxHighestScorePerPlayer = 10;
  final PlayerProgressPersistence _store;
  int _highestLevelReached = 0;

  PlayerProgress(PlayerProgressPersistence store) : _store = store;

  Future<void> getLatestFromStore() async {
    final level = await _store.getHighestLevelReached();
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (level < _highestLevelReached) {
      await _store.saveHighestLevelReached(_highestLevelReached);
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevelReached = 0;
    notifyListeners();
    _store.saveHighestLevelReached(_highestLevelReached);
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
      unawaited(_store.saveHighestLevelReached(level));
    }
  }
}
