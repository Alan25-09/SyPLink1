import 'package:flutter/material.dart';
import 'package:syplink/models/response/vacants/get_vacant.dart';
import 'package:syplink/models/response/vacants/vacants_response.dart';
import 'package:syplink/services/helpers/vacants_helper.dart';

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
