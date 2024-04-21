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
  late Future<List<VacantsResponse>> recentVacants;
  late Future<GetVacantRes> vacant;

  Future<List<VacantsResponse>> getVacants() {
    vacantsList = VacantsHelper.getVacants();
    return vacantsList;
  }

  Future<List<VacantsResponse>> getRecent() {
    recentVacants = VacantsHelper.getVacants();
    return recentVacants;
  }

  Future<GetVacantRes> getVacant(String vacantId) {
    vacant = VacantsHelper.getVacant(vacantId);
    return vacant;
  }
}
