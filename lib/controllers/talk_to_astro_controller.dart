import 'dart:convert';

import 'package:astrologer_app/models/all_astrologer.dart';
import 'package:astrologer_app/services/api_service.dart';
import 'package:astrologer_app/utils/util_functions.dart';
import 'package:astrologer_app/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkToAstroController extends GetxController {
  var astrologerList = <Astrologer>[];
  var searchedAstrologerList = Rx<List<Astrologer>?>([]);
  var filteredAstrologerList = <Astrologer>[];
  final _apiService = ApiService();

  var isFetching = false.obs;

  var showSearch = false.obs;

  var selectedSortBy = Rx<SortByItem?>(null);

  final searchTextController = TextEditingController();

  var allSkills = <Skills>{}.obs;
  var allLanguages = <Languages>{}.obs;

  var selectedLangsForFilter = <Languages>[].obs;
  var selectedSkillsForFilter = <Skills>[].obs;
  var numOfFilterSelected = 0.obs;

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
    selectedLangsForFilter.listen((_) {
      filterAstrologer();
    });
    selectedSkillsForFilter.listen((_) {
      filterAstrologer();
    });
    searchTextController.addListener(() {
      searchAstrologer();
    });
    selectedSortBy.listen((_sortBy) {
      // print(_sortBy?.title);
      sortAstrologer(_sortBy);
    });
  }

  void selectLang(Languages lang) {
    numOfFilterSelected.value += 1;
    selectedLangsForFilter.add(lang);
  }

  void deselectLang(Languages lang) {
    numOfFilterSelected.value -= 1;
    selectedLangsForFilter.remove(lang);
  }

  bool isLangSelected(Languages lang) {
    return selectedLangsForFilter.contains(lang);
  }

  void selectSkill(Skills skill) {
    numOfFilterSelected.value += 1;
    selectedSkillsForFilter.add(skill);
  }

  void deselectSkill(Skills skill) {
    numOfFilterSelected.value -= 1;
    selectedSkillsForFilter.remove(skill);
  }

  bool isSkillSelected(Skills skill) {
    return selectedSkillsForFilter.contains(skill);
  }

  void clearAllFilters() async {
    if (selectedLangsForFilter.isEmpty && selectedSkillsForFilter.isEmpty) {
      return;
    }
    isFetching.value = true;
    numOfFilterSelected.value = 0;
    selectedLangsForFilter.clear();
    selectedSkillsForFilter.clear();
    searchedAstrologerList.value = astrologerList;
    searchedAstrologerList.refresh();

    await Future.delayed(const Duration(milliseconds: 350));
    isFetching.value = false;
  }

  void _createUniqueSkillSetFromAllAstrologerData() {
    var skills = <Skills>{};
    for (var _astro in astrologerList) {
      skills.addAll(_astro.skills);
    }
    allSkills.addAll(skills);
    // debugPrint(allSkills.length.toString());
  }

  void _createUniqueLanguageSetFromAllAstrologerData() {
    var langs = <Languages>{};
    for (var _astro in astrologerList) {
      langs.addAll(_astro.languages);
    }
    allLanguages.addAll(langs);
    // debugPrint(allLanguages.length.toString());
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
          _createUniqueLanguageSetFromAllAstrologerData();
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
        return name.startsWith(query) || name.contains(query);
      }).toList();
      //sort the result alphabetically.
      searchedAstrologerList.value?.sort((astro1, astro2) {
        return UtilFunctions.getAstrologerName(astro2).toLowerCase().compareTo(
              UtilFunctions.getAstrologerName(astro1).toLowerCase(),
            );
      });
    } else {
      if (numOfFilterSelected.value > 0) {
        searchedAstrologerList.value = filteredAstrologerList;
      } else {
        searchedAstrologerList.value = astrologerList;
      }
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

  void filterAstrologer() async {
    isFetching.value = true;
    if (selectedLangsForFilter.isEmpty && selectedSkillsForFilter.isEmpty) {
      searchedAstrologerList.value = astrologerList;
      searchedAstrologerList.refresh();
      //intentionally delaying as user can't understand somthing happended.
      await Future.delayed(const Duration(milliseconds: 350));
      isFetching.value = false;
      return;
    }
    List<Astrologer> _astroList = [];
    for (var _astro in astrologerList) {
      bool _skillMatched = false;
      bool _langMatched = false;
      int _skillMatchedCount = 0;
      for (var _skill in _astro.skills) {
        if (selectedSkillsForFilter.contains(_skill)) {
          _skillMatched = true;
          _skillMatchedCount += 1;
        }
      }
      int _langMatchedCount = 0;
      for (var lang in _astro.languages) {
        if (selectedLangsForFilter.contains(lang)) {
          _langMatched = true;
          _langMatchedCount += 1;
        }
      }
      _skillMatched = selectedSkillsForFilter.length <= _skillMatchedCount;
      _langMatched = selectedLangsForFilter.length <= _langMatchedCount;

      if (selectedSkillsForFilter.isEmpty) {
        if (_langMatched) {
          _astroList.add(_astro);
        }
      } else if (selectedLangsForFilter.isEmpty) {
        if (_skillMatched) {
          _astroList.add(_astro);
        }
      } else {
        if (_skillMatched && _langMatched) {
          _astroList.add(_astro);
        }
      }
    }
    filteredAstrologerList = _astroList;
    searchedAstrologerList.value = _astroList;
    searchedAstrologerList.refresh();

    //intentionally delaying as user can't understand somthing happended.
    await Future.delayed(const Duration(milliseconds: 350));

    isFetching.value = false;
  }

  showFilterBottomSheet() {
    return Get.bottomSheet(FilterBottomSheet());
  }
}

class SortByItem {
  final int id;
  final String title;

  SortByItem({required this.id, required this.title});
}
