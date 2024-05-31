import 'dart:convert';

AppliedPost appliedPostFromJson(String str) =>
    AppliedPost.fromJson(json.decode(str));

String appliedPostToJson(AppliedPost data) => json.encode(data.toJson());

class AppliedPost {
  final String vacant;

  AppliedPost({
    required this.vacant,
  });

  factory AppliedPost.fromJson(Map<String, dynamic> json) => AppliedPost(
        vacant: json["vacant"],
      );

  Map<String, dynamic> toJson() => {
        "vacant": vacant,
      };
}
