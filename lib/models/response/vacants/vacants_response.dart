import 'dart:convert';

List<VacantsResponse> vacantsResponseFromJson(String str) =>
    List<VacantsResponse>.from(
        json.decode(str).map((x) => VacantsResponse.fromJson(x)));

class VacantsResponse {
  VacantsResponse({
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
    // required this.createdAt,
    // required this.updatedAt,
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
  // final DateTime createdAt;
  // final DateTime updatedAt;

  factory VacantsResponse.fromJson(Map<String, dynamic> json) =>
      VacantsResponse(
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
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
