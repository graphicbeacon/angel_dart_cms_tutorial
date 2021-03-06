import 'package:angel_framework/angel_framework.dart';
import 'package:file/local.dart';

import 'src/config.dart' as config;
import 'src/routes.dart' as routes;
import 'src/services.dart' as services;

Future configureServer(Angel app) async {
  var fs = const LocalFileSystem();

  await app.configure(config.configureServer(fs));
  await app.configure(routes.configureServer());
  await app.configure(services.configureServer);
}
