import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_hot/angel_hot.dart';

import 'package:simple_blog_cms/simple_blog_cms.dart' as simple_blog_cms;

void main(List<String> arguments) async {
  var hot = HotReloader(() async {
    var app = Angel(reflector: MirrorsReflector());

    await app.configure(simple_blog_cms.configureServer);

    return app;
  }, [Directory('lib')]);

  var http = await hot.startServer('localhost', 3000);

  print(
      'simple_blog_cms server listening at http://${http.address.address}:${http.port}');
}
