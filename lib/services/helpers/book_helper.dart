import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhubv2_0/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhubv2_0/models/response/bookmarks/bookmark.dart';
import 'package:jobhubv2_0/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();


}
