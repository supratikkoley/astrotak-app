import 'package:astrologer_app/utils/app_texts.dart';
import 'package:astrologer_app/utils/asset_paths.dart';
import 'package:astrologer_app/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanchangPage extends StatelessWidget {
  const PanchangPage({Key? key}) : super(key: key);

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
            scale: 1.3,
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
            _buildDateAndLocationInputContainer(),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    7,
                    (index) => IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              Text(
                                "day",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                "05:26 PM",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            color: Colors.black26,
                            thickness: 1.0,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateAndLocationInputContainer() {
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
                  onTap: () {},
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
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
                    hintText: "Enter location",
                    hintStyle: TextStyle(fontSize: 12.5),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
