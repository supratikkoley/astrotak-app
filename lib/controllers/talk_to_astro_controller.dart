import 'dart:convert';

import 'package:astrologer_app/models/all_astrologer.dart';
import 'package:astrologer_app/services/api_service.dart';
import 'package:astrologer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkToAstroController extends GetxController {
  var astrologerList = <Astrologer>[];
  var searchedAstrologerList = Rx<List<Astrologer>?>([]);
  final _apiService = ApiService();

  var isFetching = false.obs;

  var showSearch = false.obs;

  var selectedSortBy = Rx<SortByItem?>(null);

  final searchTextController = TextEditingController();

  var allSkills = <Skills>{};

  var sortByList = [
    SortByItem(id: 1, title: 'Experience- high to low'),
    SortByItem(id: 2, title: 'Experience- low to high'),
    SortByItem(id: 3, title: 'Price- high to low'),
    SortByItem(id: 4, title: 'Price- low to high'),
  ];

  @override
  void onInit() {
    super.onInit();
    getAllAstrologer();
    searchTextController.addListener(() {
      searchAstrologer();
    });
    selectedSortBy.listen((_sortBy) {
      // print(_sortBy?.title);
      sortAstrologer(_sortBy);
    });
  }

  void _createUniqueSkillSetFromAllAstrologerData() {
    var skills = <Skills>{};
    for (var _astro in astrologerList) {
      skills.addAll(_astro.skills);
    }
    allSkills.addAll(skills);
    print(allSkills.length);
  }

  Future<void> getAllAstrologer() async {
    isFetching.value = true;
    await _apiService.fetchAllAstrologer().then((res) {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        if (_apiService.checkResponse(resJson)) {
          var allAstrologer = AllAstrologer.fromJson(resJson);
          astrologerList = [];
          astrologerList.addAll(allAstrologer.data);
          searchedAstrologerList.value?.addAll(allAstrologer.data);
          searchedAstrologerList.refresh();
          _createUniqueSkillSetFromAllAstrologerData();
        }
      }
    }).catchError((err) {
      debugPrint("$err");
    });
    isFetching.value = false;
  }

  void searchAstrologer() {
    var query = searchTextController.text;
    query = query.toLowerCase();
    if (query.isNotEmpty) {
      searchedAstrologerList.value = astrologerList.where((_astrologer) {
        var name = UtilFunctions.getAstrologerName(_astrologer).toLowerCase();
        return name.contains(query);
      }).toList();
    } else {
      searchedAstrologerList.value = astrologerList;
    }
    searchedAstrologerList.refresh();
  }

  void sortAstrologer(SortByItem? _sortBy) {
    if (_sortBy == null) {
      searchedAstrologerList.value = astrologerList;
      searchedAstrologerList.refresh();
      return;
    }
    switch (_sortBy.id) {
      case 1:
        searchedAstrologerList.value?.sort((astro1, astro2) {
          return astro2.experience.compareTo(astro1.experience);
        });
        searchedAstrologerList.refresh();
        break;
      case 2:
        searchedAstrologerList.value?.sort((astro1, astro2) {
          return astro1.experience.compareTo(astro2.experience);
        });
        searchedAstrologerList.refresh();
        break;

      case 3:
        searchedAstrologerList.value?.sort((astro1, astro2) {
          return astro2.minimumCallDurationCharges
              .compareTo(astro1.minimumCallDurationCharges);
        });
        searchedAstrologerList.refresh();
        break;

      case 4:
        searchedAstrologerList.value?.sort((astro1, astro2) {
          return astro1.minimumCallDurationCharges
              .compareTo(astro2.minimumCallDurationCharges);
        });
        searchedAstrologerList.refresh();
        break;
      default:
        break;
    }
  }
}

class SortByItem {
  final int id;
  final String title;

  SortByItem({required this.id, required this.title});
}
