import 'dart:convert';

import 'package:astrologer_app/models/panchang_res_data.dart';
import 'package:astrologer_app/models/place_res_data.dart';
import 'package:astrologer_app/services/api_service.dart';
import 'package:astrologer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PanchangPageController extends GetxController {
  final dateController = TextEditingController();
  final locationController = TextEditingController();
  DateTime? selectedDate;
  DateTime? currentDate;
  String? selectedPlaceId;
  Place? curremtPlace;

  var panchangData = Rx<PanchangResponseData?>(null);

  Data? get getPanchagData => panchangData.value?.data;

  final _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    dateController.addListener(() {
      if (selectedPlaceId != null && dateController.text.isNotEmpty) {
        if (selectedDate != currentDate) {
          debugPrint("Fetch panchage details");
          fetchPanchang(date: selectedDate!, placeId: selectedPlaceId!);
        }
      }
    });
    locationController.addListener(() {
      if (locationController.text.isEmpty) {
        selectedPlaceId = null;
      }
      if (dateController.text.isNotEmpty && selectedPlaceId != null) {
        if (curremtPlace?.placeId != selectedPlaceId) {
          debugPrint("Fetch panchage details");
          fetchPanchang(date: selectedDate!, placeId: selectedPlaceId!);
        }
      }
    });
  }

  @override
  void dispose() {
    dateController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> pickDate(BuildContext context) async {
    await UtilFunctions.showDatePikcer(context).then((date) {
      if (date != null) {
        selectedDate = date;
        var dateString =
            DateFormat('dd ' + DateFormat.ABBR_MONTH + ' yyyy').format(date);
        dateController.text = dateString;
        currentDate = date;
      }
    });
  }

  Future<List<Place>> getPlaces(String pattern) async {
    List<Place> _places = [];
    await _apiService.getPlaces(pattern).then((res) {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        if (_apiService.checkResponse(resJson)) {
          var placeResData = PlaceResponseData.fromJson(resJson);
          _places = placeResData.data;
        }
      }
    }).catchError((err) {});
    return _places;
  }

  Future<PanchangResponseData?> fetchPanchang(
      {required DateTime date, required String placeId}) async {
    PanchangResponseData? panchangResponseData;
    await _apiService.fetchPanchag(date: date, placeId: placeId).then((res) {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        if (_apiService.checkResponse(resJson)) {
          // print(res.body);
          panchangResponseData = PanchangResponseData.fromJson(resJson);
          panchangData.value = panchangResponseData;
        }
      }
    }).catchError((err) {
      debugPrint("$err");
    });
    return panchangResponseData;
  }

  selectPlace(Place place) {
    selectedPlaceId = place.placeId;
    locationController.text = place.placeName;
    curremtPlace = place;
  }
}
