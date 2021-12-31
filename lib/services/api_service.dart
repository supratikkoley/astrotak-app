import 'dart:convert';

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

  Future<http.Response> fetchPanchag(
      {required DateTime date, required String placeId}) async {
    var url = Urls.panchangUrl;
    var headers = {'Content-Type': 'application/json'};
    var _data = {
      "day": date.day,
      "month": date.month,
      "year": date.year,
      "placeId": placeId
    };
    var _body = json.encode(_data);
    var res = await http
        .post(
          Uri.parse(url),
          body: _body,
          headers: headers,
        )
        .catchError((err) => throw err);

    return res;
  }

  Future<http.Response> fetchAllAstrologer() async {
    var url = Urls.allAstrologerUrl;
    var res = await http.get(Uri.parse(url)).catchError((err) {
      throw err;
    });
    return res;
  }

  bool checkResponse(resJson) {
    if (resJson["httpStatusCode"] == 200 &&
        resJson["httpStatus"] == "OK" &&
        resJson["success"] == true) {
      return true;
    }
    return false;
  }
}
