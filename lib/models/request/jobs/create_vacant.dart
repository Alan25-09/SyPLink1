import 'dart:convert';

String createVacantRequestToJson(CreateVacantRequest data) =>
    json.encode(data.toJson());

class CreateVacantRequest {
  CreateVacantRequest({
    //required this.id,
    required this.title,
    required this.area,
    required this.responsibleId,
    required this.responsibleName,
    required this.description,
    required this.requirements,
    required this.schedule,
    required this.status,
    required this.imageUrl,
  });

  //final String id;
  final String title;
  final String area;
  final String responsibleId;
  final String responsibleName;
  final String description;
  final List<String> requirements;
  final String schedule;
  final bool status;
  final String imageUrl;

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "title": title,
        "area": area,
        "responsibleId": responsibleId,
        "responsibleName": responsibleName,
        "description": description,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "schedule": schedule,
        "status": status,
        "imageUrl": imageUrl,
      };
}
