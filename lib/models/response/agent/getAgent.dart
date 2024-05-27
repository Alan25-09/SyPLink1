import 'dart:convert';

GetAgent getAgentFromJson(String str) => GetAgent.fromJson(json.decode(str));

class GetAgent {
  final String id;
  final String userId;
  final String uid;

  GetAgent({
    required this.id,
    required this.userId,
    required this.uid,
  });

  factory GetAgent.fromJson(Map<String, dynamic> json) => GetAgent(
        id: json["_id"],
        userId: json["userId"],
        uid: json["uid"],
      );
}
