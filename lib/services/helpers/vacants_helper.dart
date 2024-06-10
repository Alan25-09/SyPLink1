import 'package:http/http.dart' as https;
import 'package:syplink/models/response/vacants/get_vacant.dart';
import 'package:syplink/models/response/vacants/vacants_response.dart';
import 'package:syplink/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VacantsHelper {
  static var client = https.Client();

  static Future<List<VacantsResponse>> getVacants() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.vacants);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var vacantList = vacantsResponseFromJson(response.body);
      return vacantList;
    } else {
      throw Exception('No se pudo cargar la lista de vacantes');
    }
  }

  static Future<GetVacantRes> getVacant(String vacantId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.vacants}/$vacantId");

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var vacant = getVacantResFromJson(response.body);
      return vacant;
    } else {
      throw Exception('No se pudo cargar la lista de vacantes');
    }
  }

  static Future<List<VacantsResponse>> getRecent() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.vacants, {"new": "true"});
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var vacantList = vacantsResponseFromJson(response.body);
      return vacantList;
    } else {
      throw Exception('No se pudo cargar la lista de vacantes');
    }
  }

  static Future<bool> createVacant(String model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, Config.vacants);

      var response =
          await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateVacant(String model, String vacantId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        return false;
      }

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token'
      };

      var url = Uri.https(Config.apiUrl, "${Config.vacants}/$vacantId");

      var response =
          await client.put(url, headers: requestHeaders, body: model);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<List<VacantsResponse>> searchVacants(String query) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.search}/$query");
    print(url);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var vacantList = vacantsResponseFromJson(response.body);
      return vacantList;
    } else {
      throw Exception('No se pudo cargar la lista de vacantes');
    }
  }
}
