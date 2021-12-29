import 'package:astrologer_app/utils/urls.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> getPlaces(String placePrefix) async {
    var url = Urls.placeUrl + "?inputPlace=$placePrefix";
    var res = await http
        .get(
          Uri.parse(url),
        )
        .catchError((err) => throw err);

    return res;
  }
}
