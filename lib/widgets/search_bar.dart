import 'package:astrologer_app/controllers/talk_to_astro_controller.dart';
import 'package:astrologer_app/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, this.show = false}) : super(key: key);
  final bool show;

  final TalkToAstroController _astroController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: show ? 8.0 : 0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
        height: show ? 45 : 0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          height: show ? 45 : 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: Colors.grey[200]!,
                blurRadius: 0,
              ),
            ],
          ),
          child: show
              ? TextField(
                  controller: _astroController.searchTextController,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade400.withOpacity(0.25),
                    hintText: "Search Astrologer",
                    hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w100,
                        ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorHelper.orange.withOpacity(0.75),
                      size: 19,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _astroController.searchTextController.clear();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: ColorHelper.orange.withOpacity(0.8),
                        size: 19,
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
