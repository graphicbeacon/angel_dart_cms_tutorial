// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Article extends _Article {
  Article(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.slug,
      this.content,
      this.publishDate});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  String title;

  @override
  String slug;

  @override
  String content;

  @override
  DateTime publishDate;

  Article copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      String title,
      String slug,
      String content,
      DateTime publishDate}) {
    return Article(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        content: content ?? this.content,
        publishDate: publishDate ?? this.publishDate);
  }

  bool operator ==(other) {
    return other is _Article &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.title == title &&
        other.slug == slug &&
        other.content == content &&
        other.publishDate == publishDate;
  }

  @override
  int get hashCode {
    return hashObjects(
        [id, createdAt, updatedAt, title, slug, content, publishDate]);
  }

  @override
  String toString() {
    return "Article(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, title=$title, slug=$slug, content=$content, publishDate=$publishDate)";
  }

  Map<String, dynamic> toJson() {
    return ArticleSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

const ArticleSerializer articleSerializer = ArticleSerializer();

class ArticleEncoder extends Converter<Article, Map> {
  const ArticleEncoder();

  @override
  Map convert(Article model) => ArticleSerializer.toMap(model);
}

class ArticleDecoder extends Converter<Map, Article> {
  const ArticleDecoder();

  @override
  Article convert(Map map) => ArticleSerializer.fromMap(map);
}

class ArticleSerializer extends Codec<Article, Map> {
  const ArticleSerializer();

  @override
  get encoder => const ArticleEncoder();
  @override
  get decoder => const ArticleDecoder();
  static Article fromMap(Map map) {
    return Article(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        title: map['title'] as String,
        slug: map['slug'] as String,
        content: map['content'] as String,
        publishDate: _dateFromString(map['publish_date']));
  }

  static Map<String, dynamic> toMap(_Article model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'title': model.title,
      'slug': model.slug,
      'content': model.content,
      'publish_date': _dateToString(model.publishDate)
    };
  }
}

abstract class ArticleFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    title,
    slug,
    content,
    publishDate
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String title = 'title';

  static const String slug = 'slug';

  static const String content = 'content';

  static const String publishDate = 'publish_date';
}
