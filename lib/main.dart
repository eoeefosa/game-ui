// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
// import 'package:simplegame/firebase_options.dart';
import 'package:simplegame/routes.dart';
import 'package:simplegame/src/app_lifecycle/app_lifecycle.dart';
// import 'package:simplegame/src/carashlytics/crashlytics.dart';
import 'package:simplegame/src/settings/persistence/local_storage_settings_persistences.dart';
import 'package:simplegame/src/settings/persistence/settings_persistence.dart';
import 'package:simplegame/src/settings/settings.dart';
import 'package:simplegame/src/style/palette.dart';
import 'package:simplegame/src/style/snack_bar.dart';

// Future<void> main() async {
  // FirebaseCrashlytics? crashlytics;
  // if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
  //   try {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform,
  //     );
  //     crashlytics = FirebaseCrashlytics.instance;
  //   } catch (e) {
  //     debugPrint("Firebase Couldn't be initialized:$e");
  //   }
  // }

  // await guardWithCrashlytics(
  //   guardedMain,
  //   crashlytics: crashlytics,
  // );
// }

// void guardedMain() {
//   if (kReleaseMode) {
//     Logger.root.level = Level.WARNING;
//   }
//   Logger.root.onRecord.listen((record) {
//     debugPrint('${record.level.name}:${record.time}:'
//         '${record.loggerName}'
//         '${record.message}');
//   });
//   WidgetsFlutterBinding.ensureInitialized();
//   _log.info('Going  full screen');
//   SystemChrome.setEnabledSystemUIMode(
//     SystemUiMode.edgeToEdge,
//   );
//   runApp(MyApp());
// }
void main(){
  runApp(MyApp());
}
Logger _log = Logger('main.dart');

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final SettingsPersistence settingsPersistence =
      LocalStorageSettingsPersistence();

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider<SettingsController>(
            create: (context) =>
                SettingsController(persistence: settingsPersistence)
                  ..loadStateFromPersistence(),
          ),
          Provider(
            create: (context) => Palette(),
          )
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();
          return MaterialApp.router(
            title: 'Simple Game',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.darkPen,
                background: palette.backgroundMain,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(color: palette.ink),
              ),
              useMaterial3: true,
            ),
            // This fix the go router error i had
            routerConfig: AppRoutes.routes,
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        }),
      ),
    );
  }
}
