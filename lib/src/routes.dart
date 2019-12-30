import 'package:angel_framework/angel_framework.dart';

AngelConfigurer configureServer() => (Angel app) {
      app.get('/', (req, res) => res.render('articles'));
    };
