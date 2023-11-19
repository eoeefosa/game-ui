import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/audio/audio_controller.dart';
import 'package:simplegame/src/audio/sounds.dart';
import 'package:simplegame/src/game_intervals/level_state.dart';
import 'package:simplegame/src/level_selection/game_levels.dart';
import 'package:simplegame/src/player_progress/player_progress.dart';
import 'package:simplegame/src/style/palette.dart';
import 'package:simplegame/src/win_game/win_game_screen.dart';
import '../games_services/score.dart';

class PlaySessionScreen extends StatefulWidget {
  const PlaySessionScreen({super.key, required this.level});
  // static const route = '';
  final GameLevel level;

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger("PlaySessionScreen");
  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            onWin: _playerWon,
            goal: widget.level.difficulty,
          ),
        ),
      ],
    );
  }

  Future<void> _playerWon() async {
    _log.info('Level ${widget.level.number} won');
    final score = Score(
      widget.level.number,
      widget.level.difficulty,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.level.number);

    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;
    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.congrats);

    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go(WinGameScreen.route, extra: {'score': score});
  }
}
