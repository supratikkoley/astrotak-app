import 'package:astrologer_app/controllers/talk_to_astro_controller.dart';
import 'package:astrologer_app/utils/asset_paths.dart';
import 'package:astrologer_app/utils/color_helper.dart';
import 'package:astrologer_app/widgets/astrologer_card.dart';
import 'package:astrologer_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TalkToAstrologerPage extends StatelessWidget {
  TalkToAstrologerPage({Key? key}) : super(key: key);

  final _talkToAstroController = Get.put(TalkToAstroController());

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
            scale: 1.2,
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
              scale: 1.7,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _topActionBar(context),
          Obx(
            () => SearchBar(
              show: _talkToAstroController.showSearch.value,
            ),
          ),
          Obx(
            () => _talkToAstroController.isFetching.value
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        color: ColorHelper.orange,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: _talkToAstroController
                              .searchedAstrologerList.value?.length ??
                          0,
                      padding: const EdgeInsets.only(
                          top: 0, right: 0, left: 16, bottom: 16),
                      itemBuilder: (context, index) {
                        return AstrologerCard(
                          astrologer: _talkToAstroController
                              .searchedAstrologerList.value![index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _topActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 10.0,
        left: 16.0,
        // top: 16.0,
        bottom: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Talk to an Astrolger",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  _talkToAstroController.showSearch.toggle();
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 11, right: 11, bottom: 10, left: 11),
                  child: Image.asset(
                    AssetPaths.searchIcon,
                    scale: 2.8,
                  ),
                ),
              ),
              // const SizedBox(width: 14),
              InkWell(
                onTap: () {
                  _talkToAstroController.showFilterBottomSheet();
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 11, right: 11, bottom: 10, left: 11),
                      // color: Colors.yellow,
                      child: Image.asset(
                        AssetPaths.filterIcon,
                        scale: 2.8,
                      ),
                    ),
                    Obx(
                      () => _talkToAstroController.numOfFilterSelected.value > 0
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "${_talkToAstroController.numOfFilterSelected.value}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(width: 0, height: 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              PopupMenuButton(
                tooltip: 'Sort',
                child: Image.asset(
                  AssetPaths.sortIcon,
                  scale: 2.8,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      enabled: false,
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sort By",
                                  style: GoogleFonts.montserrat(
                                    color: ColorHelper.orange,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.25,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...List.generate(
                      _talkToAstroController.sortByList.length,
                      (index) => PopupMenuItem(
                        child: Obx(
                          () => RadioListTile<SortByItem>(
                            groupValue:
                                _talkToAstroController.selectedSortBy.value,
                            onChanged: (value) {
                              _talkToAstroController.selectedSortBy.value =
                                  value;
                            },
                            value: _talkToAstroController.sortByList[index],
                            title: Text(
                                _talkToAstroController.sortByList[index].title),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                        ),
                      ),
                    )
                  ];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
