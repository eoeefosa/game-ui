import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/screens/home.dart';
import 'package:simplegame/screens/levels.dart';
import 'package:simplegame/src/settings/settings_screen.dart';
import 'package:simplegame/src/style/my_transition.dart';
import 'package:simplegame/src/style/palette.dart';

class AppRoutes {
  static final routes = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            return const Home(key: Key('Home'));
          },
          routes: [
            GoRoute(
              path: 'levels',
              pageBuilder: (context, state) => buildMyTransition(
                child: const Levels(key: Key("Level")),
                color: context.watch<Palette>().backgroundLevelSelection,
              ),
            ),
            GoRoute(
                path: 'settings',
                builder: (context, state) => const SettingsScreen())
          ]),
    ],
  );
}
