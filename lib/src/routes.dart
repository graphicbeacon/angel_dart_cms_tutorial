import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'models/article.dart';
import './validator.dart';

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

        var validationResult = articleValidator.check(req.bodyAsMap);
        var templateData = <String, dynamic>{};

        if (validationResult.errors.isNotEmpty) {
          templateData['errors'] = validationResult.errors;

          var title = req.bodyAsMap['title'];
          var slug = req.bodyAsMap['slug'];
          var publishDate = req.bodyAsMap['publish_date'];
          var content = req.bodyAsMap['content'];

          templateData['article'] = Article(
            title: title.isNotEmpty ? title : null,
            slug: slug.isNotEmpty ? slug : null,
            publishDate:
                publishDate.isNotEmpty ? DateTime.parse(publishDate) : null,
            content: content.isNotEmpty ? content : null,
          );

          res.statusCode = HttpStatus.badRequest;
        } else {
          var articleService = app.findService('articles');
          var article = ArticleSerializer.fromMap(req.bodyAsMap);

          article.createdAt = DateTime.now();
          article.updatedAt = DateTime.now();

          var createdArticle = await articleService.create(article.toJson());

          templateData.addAll({
            'created': true,
            'article': ArticleSerializer.fromMap(createdArticle)
          });
        }

        await res.render('article_form', templateData);
      });

      app.get('/posts/:slug', (req, res) async {
        var articleService = app.findService('articles');
        var articleMap = await articleService
            .findOne({'query': where.eq('slug', req.params['slug'])});
        var article = ArticleSerializer.fromMap(articleMap);
        await res.render('article', {'article': article});
      });

      app.get('/posts/:slug/edit', (req, res) async {
        var articleService = app.findService('articles');
        var articleMap = await articleService
            .findOne({'query': where.eq('slug', req.params['slug'])});
        var article = ArticleSerializer.fromMap(articleMap);
        await res.render('article_form', {'editing': true, 'article': article});
      });

      app.post('/posts/:slug/edit', (req, res) async {
        await req.parseBody();

        var articleService = app.findService('articles');
        var methodOverride = req.bodyAsMap['_method'];

        if (methodOverride is String && methodOverride == 'delete') {
          await articleService.remove(req.bodyAsMap['id']);
          await res.redirect('/');
          return;
        }

        var validationResult = articleValidator.check(req.bodyAsMap);
        var templateData = <String, dynamic>{};

        if (validationResult.errors.isNotEmpty) {
          templateData['errors'] = validationResult.errors;

          var id = req.bodyAsMap['id'];
          var title = req.bodyAsMap['title'];
          var slug = req.bodyAsMap['slug'];
          var publishDate = req.bodyAsMap['publish_date'];
          var content = req.bodyAsMap['content'];

          templateData['article'] = Article(
            id: id,
            title: title.isNotEmpty ? title : null,
            slug: slug.isNotEmpty ? slug : null,
            publishDate:
                publishDate.isNotEmpty ? DateTime.parse(publishDate) : null,
            content: content.isNotEmpty ? content : null,
          );

          res.statusCode = HttpStatus.badRequest;
        } else {
          var article = ArticleSerializer.fromMap(req.bodyAsMap);

          article.updatedAt = DateTime.now();

          var updatedArticle =
              await articleService.update(article.id, article.toJson());

          templateData.addAll({
            'edited': true,
            'article': ArticleSerializer.fromMap(updatedArticle)
          });
        }

        await res.render('article_form', templateData);
      });

      // Throw a 404 if no route matched the request
      app.fallback((req, res) => throw AngelHttpException.notFound(
          message: "That route doesn't exist"));
    };
