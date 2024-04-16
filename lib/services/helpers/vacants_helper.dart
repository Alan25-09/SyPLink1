import 'package:http/http.dart' as https;
import 'package:jobhubv2_0/models/response/vacants/get_vacant.dart';
import 'package:jobhubv2_0/models/response/vacants/vacants_response.dart';
import 'package:jobhubv2_0/services/config.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<VacantsResponse>> getVacants() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.vacants);
    print(url);
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
}
