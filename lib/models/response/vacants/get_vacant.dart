import 'dart:convert';

GetVacantRes getVacantResFromJson(String str) =>
    GetVacantRes.fromJson(json.decode(str));

String getVacantResToJson(GetVacantRes data) => json.encode(data.toJson());

class GetVacantRes {
  GetVacantRes({
    required this.id,
    required this.title,
    required this.area,
    required this.responsibleId,
    required this.responsibleName,
    required this.description,
    required this.requirements,
    required this.schedule,
    required this.status,
    required this.imageUrl,
    //required this.updatedAt,
  });

  final String id;
  final String title;
  final String area;
  final String responsibleId;
  final String responsibleName;
  final String description;
  final List<String> requirements;
  final String schedule;
  final bool status;
  final String imageUrl;
  //final DateTime updatedAt;

  factory GetVacantRes.fromJson(Map<String, dynamic> json) => GetVacantRes(
        id: json["_id"],
        title: json["title"],
        area: json["area"],
        responsibleId: json["responsibleId"],
        responsibleName: json["responsibleName"],
        description: json["description"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        schedule: json["schedule"],
        status: json["status"],
        imageUrl: json["imageUrl"],
        //updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "area": area,
        "responsibleId": responsibleId,
        "responsibleName": responsibleName,
        "description": description,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "schedule": schedule,
        "status": status,
        "imageUrl": imageUrl,
        //"updatedAt": updatedAt.toIso8601String(),
      };
}
