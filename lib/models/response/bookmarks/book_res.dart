import 'dart:convert';

BookMarkReqRes bookMarkReqResFromJson(String str) =>
    BookMarkReqRes.fromJson(json.decode(str));

String bookMarkReqResToJson(BookMarkReqRes data) => json.encode(data.toJson());

class BookMarkReqRes {
  final String vacant;

  BookMarkReqRes({
    required this.vacant,
  });

  factory BookMarkReqRes.fromJson(Map<String, dynamic> json) => BookMarkReqRes(
        vacant: json["vacant"],
      );

  Map<String, dynamic> toJson() => {
        "vacant": vacant,
      };
}
