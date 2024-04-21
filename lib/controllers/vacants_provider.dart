import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/constants/app_constants.dart';
import 'package:jobhubv2_0/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhubv2_0/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhubv2_0/models/response/vacants/get_vacant.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';
import 'package:jobhubv2_0/services/helpers/book_helper.dart';
import 'package:jobhubv2_0/services/helpers/vacants_helper.dart';

class VacantsNotifier extends ChangeNotifier {
  late Future<List<VacantsResponse>> vacantsList;
  late Future<GetVacantRes> vacant;

  Future<List<VacantsResponse>> getVacants() {
    vacantsList = JobsHelper.getVacants();
    return vacantsList;
  }

  Future<GetVacantRes> getVacant(String vacantId) {
    vacant = JobsHelper.getVacant(vacantId);
    return vacant;
  }
}
