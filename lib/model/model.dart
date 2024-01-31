// To parse this JSON data, do
//
//     final welcomeSuccess = welcomeSuccessFromJson(jsonString);

import 'dart:convert';

WelcomeSuccess welcomeSuccessFromJson(String str) =>
    WelcomeSuccess.fromJson(json.decode(str));

String welcomeSuccessToJson(WelcomeSuccess data) => json.encode(data.toJson());

class WelcomeSuccess {
  int status;
  String message;
  List<Datum> data;

  WelcomeSuccess({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WelcomeSuccess.fromJson(Map<String, dynamic> json) => WelcomeSuccess(
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
  int date;
  String excerpt;
  String? image;
  String relativeTime;
  String syndicate;
  String title;
  String url;
  bool isOld;

  Datum({
    required this.date,
    required this.excerpt,
    this.image,
    required this.relativeTime,
    required this.syndicate,
    required this.title,
    required this.url,
    required this.isOld,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        excerpt: json["excerpt"],
        image: json["image"],
        relativeTime: json["relativeTime"],
        syndicate: json["syndicate"],
        title: json["title"],
        url: json["url"],
        isOld: json["isOld"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "excerpt": excerpt,
        "image": image,
        "relativeTime": relativeTime,
        "syndicate": syndicate,
        "title": title,
        "url": url,
        "isOld": isOld,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
