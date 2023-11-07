import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/settings/cutom_name_dialog.dart';
import 'package:simplegame/src/settings/settings.dart';
import 'package:simplegame/src/style/palette.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: ListView(
        children: [
          _gap,
          const Text("Settings"),
          _gap,
          const _NameChangeLine('Name'),
          ValueListenableBuilder<bool>(
            valueListenable: settings.soundsOn,
            builder: (context, soundOn, child) => _SettingsLine(
              'Sound Fx',
              Icon(soundOn ? Icons.graphic_eq : Icons.volume_off),
              onSelected: () => settings.toggleSoundsOn(),
            ),
          ),
          _gap,
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: const Text("Back"),
          )
        ],
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Text(title),
          const Spacer(),
          ValueListenableBuilder(
            valueListenable: settings.playerName,
            builder: (context, name, child) => Text(name),
          ),
        ]),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onSelected;
  // ignore: unused_element
  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Text(title),
          const Spacer(),
          icon,
        ]),
      ),
    );
  }
}
