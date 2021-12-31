import 'package:astrologer_app/controllers/panchang_page_controller.dart';
import 'package:astrologer_app/models/panchang_res_data.dart';
import 'package:astrologer_app/models/place_res_data.dart';
import 'package:astrologer_app/utils/app_texts.dart';
import 'package:astrologer_app/utils/asset_paths.dart';
import 'package:astrologer_app/utils/color_helper.dart';
import 'package:astrologer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class PanchangPage extends StatelessWidget {
  PanchangPage({Key? key}) : super(key: key);

  final _panchangPageController = Get.put(PanchangPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: null,
          icon: Image.asset(
            AssetPaths.hamburgerIcon,
            scale: 1.5,
          ),
        ),
        title: Image.asset(
          AssetPaths.logoIcon,
          scale: 5.5,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: null,
            icon: Image.asset(
              AssetPaths.profileIcon,
              scale: 1.6,
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 18.5,
                  ),
                  Text(
                    "Daily Panchang",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                AppTexts.introductoryText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 12),
              _buildDateAndLocationInputContainer(context),
              const SizedBox(height: 12),
              Obx(
                () => _panchangPageController.panchangData.value != null
                    ? Column(
                        children: [
                          smallDetailsRow(
                              _panchangPageController.panchangData.value!),
                          const Divider(
                            color: Colors.black26,
                            thickness: 1.0,
                            height: 20,
                          ),
                          const SizedBox(height: 14),
                          detailedTable(
                            title: "Tithi",
                            data: _panchangPageController.getPanchagData!.tithi
                                .toJson(),
                          ),
                          const SizedBox(height: 14),
                          detailedTable(
                            title: "Nakshatra",
                            data: _panchangPageController
                                .getPanchagData!.nakshatra
                                .toJson(),
                          ),
                          const SizedBox(height: 14),
                          detailedTable(
                            title: "Yog",
                            data: _panchangPageController.getPanchagData!.yog
                                .toJson(),
                          ),
                          const SizedBox(height: 14),
                          detailedTable(
                            title: "Karan",
                            data: _panchangPageController.getPanchagData!.karan
                                .toJson(),
                          ),
                        ],
                      )
                    : const SizedBox(width: 0, height: 0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateAndLocationInputContainer(BuildContext context) {
    return Container(
      color: ColorHelper.lightSkinColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Date:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: Get.width * 0.6,
                // height: 44,
                child: TextField(
                  controller: _panchangPageController.dateController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Select date",
                    hintStyle: TextStyle(fontSize: 12.5),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
                    suffixIcon:
                        Icon(Icons.arrow_drop_down, color: Colors.black),
                  ),
                  readOnly: true,
                  onTap: () async {
                    await _panchangPageController.pickDate(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Location:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: Get.width * 0.6,
                // height: 44,
                child: TypeAheadFormField<Place>(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                    controller: _panchangPageController.locationController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
                      hintText: "Enter location",
                      hintStyle: TextStyle(fontSize: 12.5),
                    ),
                  ),
                  onSuggestionSelected: (suggestion) {
                    _panchangPageController.selectPlace(suggestion);
                  },
                  itemBuilder: (context, place) {
                    return ListTile(title: Text(place.placeName));
                  },
                  suggestionsCallback: (pattern) {
                    return _panchangPageController.getPlaces(pattern);
                  },
                  hideOnError: true,
                  hideOnEmpty: true,
                  suggestionsBoxVerticalOffset: 1.0,
                  loadingBuilder: (context) {
                    return const SizedBox(
                      height: 50,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            color: ColorHelper.orange,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error) {
                    return Container();
                  },
                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    hasScrollbar: true,
                  ),
                  noItemsFoundBuilder: (context) {
                    // ignore: avoid_unnecessary_containers
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No items found!",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget smallDetailsRow(PanchangResponseData panchangResponseData) {
    var data = panchangResponseData.data;
    Widget rowDataTile(
            {String? title, String? subTitle, bool haveDivider = true}) =>
        IntrinsicHeight(
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "$title",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      fontSize: 9.0,
                    ),
                  ),
                  const SizedBox(height: 2.2),
                  Text(
                    "$subTitle",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
              haveDivider
                  ? const VerticalDivider(
                      color: Colors.black26,
                      thickness: 1.0,
                      width: 20,
                    )
                  : const SizedBox(width: 0, height: 0)
            ],
          ),
        );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          rowDataTile(title: 'Day', subTitle: data.day),
          rowDataTile(title: 'Sunrise', subTitle: data.sunrise),
          rowDataTile(title: 'Sunset', subTitle: data.sunset),
          rowDataTile(title: 'Moonrise', subTitle: data.moonrise),
          rowDataTile(title: 'Moonset', subTitle: data.moonset),
          rowDataTile(title: 'Vedic Sunrise', subTitle: data.vedicSunrise),
          rowDataTile(
            title: 'Vedic Sunset',
            subTitle: data.vedicSunset,
            haveDivider: false,
          ),
        ],
      ),
    );
  }

  Widget detailedTable(
      {required String title, required Map<String, dynamic> data}) {
    var details = data["details"] as Map<String, dynamic>;
    var endTime = data["end_time"] as Map<String, dynamic>;
    var detailKeys = details.keys.toList();

    var _titleColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: detailKeys
              .map(
                (key) => Padding(
                  padding:
                      const EdgeInsets.only(top: 6.5, bottom: 6.5, left: 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.3,
                        child: Text(
                          "${UtilFunctions.formatUnderscoreString(key)}:",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.55,
                        child: Text(
                          "${details[key]}",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList() +
          [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.3,
                    child: Text(
                      "${UtilFunctions.formatUnderscoreString("end_time")}:",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.55,
                    child: Text(
                      UtilFunctions.formatEndTime(endTime),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        _titleColumn,
      ],
    );
  }
}
