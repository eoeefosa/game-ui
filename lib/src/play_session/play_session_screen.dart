import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/audio/audio_controller.dart';
import 'package:simplegame/src/audio/sounds.dart';
import 'package:simplegame/src/game_intervals/level_state.dart';
import 'package:simplegame/src/level_selection/game_levels.dart';
import 'package:simplegame/src/player_progress/player_progress.dart';
import 'package:simplegame/src/settings/settings_screen.dart';
import 'package:simplegame/src/style/confetti.dart';
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
  void initState() {
    super.initState();
    _startOfPlay = DateTime.now();
    // TODO: ADD reMOVED AND ADSCONTROLLER
  }

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
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.backgroundPlaySession,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkResponse(
                        onTap: () =>
                            GoRouter.of(context).push(SettingsScreen.route),
                        child: Image.asset(
                          'assets/images/settings.png',
                          semanticLabel: 'Settings',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text('Drag the slider to ${widget.level.difficulty}%'
                        ' or above!'),
                    Consumer<LevelState>(builder: (context, levelState, child) {
                      return Slider(
                        autofocus: true,
                        label: 'Level Progress',
                        value: levelState.progress / 100,
                        onChanged: (value) =>
                            levelState.setProgress((value * 100).round()),
                        onChangeEnd: (value) => levelState.evaluate(),
                      );
                    }),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => GoRouter.of(context).pop(),
                          child: const Text('Back'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox.expand(
                child: Visibility(
                    visible: _duringCelebration,
                    child: IgnorePointer(
                      child: Confetti(
                        isStopped: !_duringCelebration,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
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
