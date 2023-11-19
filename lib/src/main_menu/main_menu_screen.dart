import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/audio/audio_controller.dart';
import 'package:simplegame/src/audio/sounds.dart';
import 'package:simplegame/src/level_selection/level_selection_screen.dart';
import 'package:simplegame/src/settings/settings.dart';
import 'package:simplegame/src/settings/settings_screen.dart';
import 'package:simplegame/src/style/constants.dart';
import 'package:simplegame/src/style/palette.dart';
import 'package:simplegame/src/style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});
  static const _gap = SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    final pallete = context.watch<Palette>();
    // TODO: INITALISE gameservicecontroller
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    return Scaffold(
      backgroundColor: pallete.backgroundMain,
      body: ResponsiveScreen(
        mainAreaProminence: 0.45,
        squarishMainArea: Center(
          child: Transform.rotate(
            angle: -0.1,
            child: const Text(
              'Simple Game Template!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppConstants.fontfamilypermenent,
                fontSize: 55,
                height: 1,
              ),
            ),
          ),
        ),
        rectangularMenuArea: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonTap);
                GoRouter.of(context).go(LevelSelectionScreen.route);
              },
              child: const Text('Play'),
            ),
            _gap,
            // TODO: ACHIEVEMNETS,AND LEADERBOARD
            // _gap,
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(SettingsScreen.route),
              child: const Text('Settings'),
            ),
            _gap,
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.muted,
                builder: (context, muted, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleMuted(),
                    icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
                  );
                },
              ),
            ),
            _gap,
            const Text('Music by Mr Smith'),
            _gap,
          ],
        ),
      ),
    );
  }
}
