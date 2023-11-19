import 'dart:async';

import 'package:logging/logging.dart';

class GamesServiceController {
  static final Logger _log = Logger('GameServicesController');
  
  final Completer<bool> _signedInCompleter = Completer();

  Future<bool> get signedIn => _signedInCompleter.future;
}
