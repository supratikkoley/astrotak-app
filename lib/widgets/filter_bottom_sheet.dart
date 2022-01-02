import 'package:astrologer_app/controllers/talk_to_astro_controller.dart';
import 'package:astrologer_app/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({Key? key}) : super(key: key);

  final _astroController = Get.find<TalkToAstroController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter by",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorHelper.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.5,
                      ),
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Get.back();
                    // _astroController.clearAllFilters();
                  },
                  iconSize: 20,
                  color: Colors.black54,
                  icon: const Icon(
                    Icons.clear,
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 0.25,
              color: Colors.black,
            ),
            const SizedBox(height: 8),
            Text(
              "Language",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 16,
              children: [
                ...List.generate(_astroController.allLanguages.length, (index) {
                  var lang = _astroController.allLanguages.toList()[index];
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Checkbox(
                          value: _astroController.isLangSelected(lang),
                          onChanged: (selected) {
                            if (selected ?? false) {
                              _astroController.selectLang(lang);
                            } else {
                              _astroController.deselectLang(lang);
                            }
                          },
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(
                                width: 1.0, color: ColorHelper.orange),
                          ),
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => ColorHelper.orange,
                          ),
                        ),
                      ),
                      Text(
                        lang.name,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Skills",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 16,
              alignment: WrapAlignment.start,
              children: [
                ...List.generate(_astroController.allSkills.length, (index) {
                  var skill = _astroController.allSkills.toList()[index];

                  return Container(
                    constraints: BoxConstraints(
                      minWidth: Get.width * 0.4,
                      maxWidth: double.infinity,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => Checkbox(
                            value: _astroController.isSkillSelected(skill),
                            onChanged: (selected) {
                              if (selected ?? false) {
                                _astroController.selectSkill(skill);
                              } else {
                                _astroController.deselectSkill(skill);
                              }
                            },
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 1.0, color: ColorHelper.orange),
                            ),
                            fillColor: MaterialStateColor.resolveWith(
                              (states) => ColorHelper.orange,
                            ),
                          ),
                        ),
                        Text(
                          skill.name,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      _astroController.clearAllFilters();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[400],
                      alignment: Alignment.center,
                    ),
                    child: Center(
                      child: Text(
                        'Clear Filters',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: ColorHelper.orange.withOpacity(0.9),
                        alignment: Alignment.center),
                    child: SizedBox(
                      width: Get.width * 0.5,
                      child: Center(
                        child: Text(
                          'Show Results',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
