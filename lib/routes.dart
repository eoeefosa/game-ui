import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simplegame/src/games_services/score.dart';
import 'package:simplegame/src/level_selection/game_levels.dart';
import 'package:simplegame/src/level_selection/level_selection_screen.dart';
import 'package:simplegame/src/main_menu/main_menu_screen.dart';
import 'package:simplegame/src/play_session/play_session_screen.dart';
import 'package:simplegame/src/settings/settings_screen.dart';
import 'package:simplegame/src/style/my_transition.dart';
import 'package:simplegame/src/style/palette.dart';
import 'package:simplegame/src/win_game/win_game_screen.dart';

class AppRoutes {
  static final routes = GoRouter(
    routes: [
      GoRoute(
          path: MainMenuScreen.route,
          builder: (context, state) {
            return const MainMenuScreen(key: Key('main menu'));
          },
          routes: [
            GoRoute(
                path: LevelSelectionScreen.routename,
                pageBuilder: (context, state) => buildMyTransition(
                      child: const LevelSelectionScreen(
                        key: Key('level selection'),
                      ),
                      color: context.watch<Palette>().backgroundLevelSelection,
                    ),
                routes: [
                  GoRoute(
                    path: 'session/:level',
                    pageBuilder: (context, state) {
                      final levelNumber =
                          int.parse(state.pathParameters['level']!);
                      final level = gamelevels.singleWhere(
                          (gamelevel) => gamelevel.number == levelNumber);
                      // TODO REPLACE WITH PLAYSESSION
                      return buildMyTransition(
                        child: PlaySessionScreen(
                          level: level,
                          key: const Key('play sesion'),
                        ),
                        color: context.watch<Palette>().backgroundPlaySession,
                      );
                    },
                  ),
                  GoRoute(
                      path: 'won',
                      pageBuilder: (context, state) {
                        final map = state.extra! as Map<String, dynamic>;
                        final score = map['score'] as Score;
                        return buildMyTransition(
                          child: WinGameScreen(
                            score: score,
                            key: const Key('win game'),
                          ),
                          color: context.watch<Palette>().backgroundPlaySession,
                        );
                      })
                ]),
            GoRoute(
              path: SettingsScreen.routename,
              builder: (context, state) => const SettingsScreen(
                key: Key('settings'),
              ),
            )
          ]),
    ],
  );
}
