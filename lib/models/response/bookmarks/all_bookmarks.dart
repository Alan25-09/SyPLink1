// To parse this JSON data, do
//
//     final allBookMarks = allBookMarksFromJson(jsonString);

import 'dart:convert';

List<AllBookMarks> allBookMarksFromJson(String str) => List<AllBookMarks>.from(
    json.decode(str).map((x) => AllBookMarks.fromJson(x)));

class AllBookMarks {
  final String id;
  final Vacant vacant;

  AllBookMarks({
    required this.id,
    required this.vacant,
  });

  factory AllBookMarks.fromJson(Map<String, dynamic> json) => AllBookMarks(
        id: json["_id"],
        vacant: Vacant.fromJson(json["vacant"]),
      );
}

class Vacant {
  final String id;
  final String title;
  final String area;
  final String responsibleId;
  final String responsibleName;
  final String schedule;
  final bool status;
  final String imageUrl;

  Vacant({
    required this.id,
    required this.title,
    required this.area,
    required this.responsibleId,
    required this.responsibleName,
    required this.schedule,
    required this.status,
    required this.imageUrl,
  });

  factory Vacant.fromJson(Map<String, dynamic> json) => Vacant(
        id: json["_id"],
        title: json["title"],
        area: json["area"],
        responsibleId: json["responsibleId"],
        responsibleName: json["responsibleName"],
        schedule: json["schedule"],
        status: json["status"],
        imageUrl: json["imageUrl"],
      );
}
