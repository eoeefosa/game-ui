import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/audio/audio_controller.dart';
import 'package:simplegame/src/settings/settings.dart';
import 'package:simplegame/src/style/palette.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pallete = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: pallete.backgroundMain,
    );
  }
}
