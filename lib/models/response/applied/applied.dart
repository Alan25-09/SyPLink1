import 'dart:convert';

List<Applied> appliedFromJson(String str) =>
    List<Applied>.from(json.decode(str).map((x) => Applied.fromJson(x)));

String appliedToJson(List<Applied> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Applied {
  final String id;
  final String user;
  final Vacant vacant;

  Applied({
    required this.id,
    required this.user,
    required this.vacant,
  });

  factory Applied.fromJson(Map<String, dynamic> json) => Applied(
        id: json["_id"],
        user: json["user"],
        vacant: Vacant.fromJson(json["vacant"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "vacant": vacant.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "area": area,
        "responsibleId": responsibleId,
        "responsibleName": responsibleName,
        "schedule": schedule,
        "status": status,
        "imageUrl": imageUrl,
      };
}
