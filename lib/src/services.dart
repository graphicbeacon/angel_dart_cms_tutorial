import 'package:angel_framework/angel_framework.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:angel_mongo/angel_mongo.dart';

Future configureServer(Angel app) async {
  final db = Db('mongodb://localhost:27017/angel');

  await db.open();

  app.use('articles', MongoService(db.collection('articles')));
}
