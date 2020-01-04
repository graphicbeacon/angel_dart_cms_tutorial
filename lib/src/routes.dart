import 'package:angel_framework/angel_framework.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'models/article.dart';

AngelConfigurer configureServer() => (Angel app) {
      app.get('/', (req, res) async {
        var articleService = app.findService('articles');
        var articleList = await articleService.index();
        var articles = articleList.map((article) {
          return ArticleSerializer.fromMap(article);
        }).toList();
        await res.render('articles', {'articles': articles});
      });

      app.get('/new', (req, res) => res.render('article_form'));

      app.post('/new', (req, res) async {
        await req.parseBody();

        // print(req.bodyAsMap);
        var articleService = app.findService('articles');
        var article = ArticleSerializer.fromMap(req.bodyAsMap);

        article.createdAt = DateTime.now();
        article.updatedAt = DateTime.now();

        var createdArticle = await articleService.create(article.toJson());

        await res.render('article_form', {
          'created': true,
          'article': ArticleSerializer.fromMap(createdArticle)
        });
      });

      app.get('/posts/:slug', (req, res) async {
        var articleService = app.findService('articles');
        var articleMap = await articleService
            .findOne({'query': where.eq('slug', req.params['slug'])});
        var article = ArticleSerializer.fromMap(articleMap);
        await res.render('article', {'article': article});
      });
    };
