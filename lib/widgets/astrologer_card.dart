import 'package:astrologer_app/models/all_astrologer.dart';
import 'package:astrologer_app/utils/color_helper.dart';
import 'package:astrologer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AstrologerCard extends StatelessWidget {
  const AstrologerCard({Key? key, required this.astrologer}) : super(key: key);

  final Astrologer astrologer;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 90,
          width: Get.width * 0.3 - 24,
          color: Colors.grey[300],
          child: Image.network(
            astrologer.images.medium.imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
              );
            },
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          // color: Colors.yellow,
          width: Get.width * 0.7 - 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    UtilFunctions.getAstrologerName(astrologer),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${astrologer.experience.toInt()} Years",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.w100,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _textRow(context, text: craeteSkillsString(astrologer.skills)),
              _textRow(context, text: craeteLangString(astrologer.languages)),
              _textRow(
                context,
                text: "₹" +
                    astrologer.minimumCallDurationCharges.toInt().toString() +
                    "/ Min",
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 13.5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.call_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Talk on Call",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                      ),
                      const SizedBox(width: 18),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: ColorHelper.orange.withOpacity(0.95),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String craeteLangString(List<Languages> langs) {
    String str = '';
    for (int i = 0; i < langs.length; i++) {
      if (i == langs.length - 1) {
        str += langs[i].name;
      } else {
        str += langs[i].name + ', ';
      }
    }
    return str;
  }

  String craeteSkillsString(List<Skills> skills) {
    String str = '';
    for (int i = 0; i < skills.length; i++) {
      if (i == skills.length - 1) {
        str += skills[i].name;
      } else {
        str += skills[i].name + ', ';
      }
    }
    return str;
  }

  Widget _textRow(BuildContext context, {String? text, TextStyle? textStyle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.ac_unit,
              size: 14,
              color: ColorHelper.orange.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: 6.5),
          SizedBox(
            // color: Colors.red,
            width: Get.width * 0.6 - 50,
            child: Text(
              text ?? '',
              style: textStyle ??
                  Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w100,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
