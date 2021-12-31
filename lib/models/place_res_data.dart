import 'dart:convert';

PlaceResponseData placeResponseDataFromJson(String str) =>
    PlaceResponseData.fromJson(json.decode(str));

String placeResponseDataToJson(PlaceResponseData data) =>
    json.encode(data.toJson());

class PlaceResponseData {
  PlaceResponseData({
    required this.httpStatus,
    required this.httpStatusCode,
    required this.success,
    required this.message,
    required this.apiName,
    required this.data,
  });

  String httpStatus;
  int httpStatusCode;
  bool success;
  String message;
  String apiName;
  List<Place> data;

  factory PlaceResponseData.fromJson(Map<String, dynamic> json) =>
      PlaceResponseData(
        httpStatus: json["httpStatus"],
        httpStatusCode: json["httpStatusCode"],
        success: json["success"],
        message: json["message"],
        apiName: json["apiName"],
        data: List<Place>.from(json["data"].map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "httpStatus": httpStatus,
        "httpStatusCode": httpStatusCode,
        "success": success,
        "message": message,
        "apiName": apiName,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Place {
  Place({
    required this.placeName,
    required this.placeId,
  });

  String placeName;
  String placeId;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        placeName: json["placeName"],
        placeId: json["placeId"],
      );

  Map<String, dynamic> toJson() => {
        "placeName": placeName,
        "placeId": placeId,
      };
}
