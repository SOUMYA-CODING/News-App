import 'dart:convert';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  int count;
  dynamic next;
  dynamic previous;
  Results results;

  ArticleModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results.toJson(),
      };
}

class Results {
  bool status;
  String message;
  List<Datum> data;

  Results({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int user;
  int categories;
  String title;
  String content;
  DateTime publicationDate;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  String url;
  bool isActive;
  bool isFeatured;
  bool isTrending;
  bool isBreaking;
  int viewsCount;

  Datum({
    required this.id,
    required this.user,
    required this.categories,
    required this.title,
    required this.content,
    required this.publicationDate,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.url,
    required this.isActive,
    required this.isFeatured,
    required this.isTrending,
    required this.isBreaking,
    required this.viewsCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        user: json["user"],
        categories: json["categories"],
        title: json["title"],
        content: json["content"],
        publicationDate: DateTime.parse(json["publication_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
        url: json["url"],
        isActive: json["is_active"],
        isFeatured: json["is_featured"],
        isTrending: json["is_trending"],
        isBreaking: json["is_breaking"],
        viewsCount: json["views_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "categories": categories,
        "title": title,
        "content": content,
        "publication_date": publicationDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image,
        "url": url,
        "is_active": isActive,
        "is_featured": isFeatured,
        "is_trending": isTrending,
        "is_breaking": isBreaking,
        "views_count": viewsCount,
      };
}
