import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/audio/audio_controller.dart';
import 'package:simplegame/src/audio/sounds.dart';
import 'package:simplegame/src/player_progress/player_progress.dart';
import 'package:simplegame/src/style/constants.dart';
import 'package:simplegame/src/style/palette.dart';
import 'package:simplegame/src/style/responsive_screen.dart';

import 'game_levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  /// static const routename = 'play';
  static const routename = 'play';
  static const route = '/play';

  @override
  Widget build(BuildContext context) {
    final pallette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: pallette.backgroundLevelSelection,
      body: ResponsiveScreen(
          squarishMainArea: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Select level',
                    style: TextStyle(
                        fontFamily: AppConstants.fontfamilypermenent,
                        fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                  child: ListView(children: [
                for (final level in gamelevels)
                  ListTile(
                    enabled:
                        playerProgress.highestLevelReached >= level.number - 1,
                    onTap: () {
                      final audioController = context.read<AudioController>();
                      audioController.playSfx(SfxType.buttonTap);
                      GoRouter.of(context).go('/play/session/${level.number}');
                    },
                    // TODO: ADD TEXT STYLE
                    leading: Text(level.number.toString()),
                    title: Text('Level #${level.number}'),
                  ),
                ListTile(
                  onTap: () {
                    final audioController = context.read<AudioController>();
                    audioController.playSfx(SfxType.buttonTap);
                    GoRouter.of(context).go('/play/quiz_game');
                  },
                  title: const Text('Quiz game'),
                )
              ]))
            ],
          ),
          rectangularMenuArea: ElevatedButton(
            child: const Text('Back'),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          )),
    );
  }
}
