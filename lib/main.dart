import 'package:astrologer_app/controllers/bottom_nav_controller.dart';
import 'package:astrologer_app/pages/panchang_page.dart';
import 'package:astrologer_app/pages/talk_to_astrologer_page.dart';
import 'package:astrologer_app/utils/asset_paths.dart';
import 'package:astrologer_app/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Astrologer app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),
          bodyText2: GoogleFonts.montserrat(
            color: Colors.black87,
            fontSize: 12.0,
            // fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(BottomNavController());

  final _pages = [
    PanchangPage(),
    TalkToAstrologerPage(),
    Container(),
    Container(),
  ];

  final _bottomNavItems = [
    BottomNavIconData(
      0,
      name: 'Home',
      iconImage: AssetPaths.homeIcon,
    ),
    BottomNavIconData(
      1,
      name: 'Talk to Astrologer',
      iconImage: AssetPaths.talkIcon,
    ),
    BottomNavIconData(
      2,
      name: 'Ask Question',
      iconImage: AssetPaths.askIcon,
    ),
    BottomNavIconData(
      3,
      name: 'Reports',
      iconImage: AssetPaths.reportsIcon,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GetX<BottomNavController>(
      builder: (controller) {
        return Scaffold(
          body: _pages[controller.selectedPageIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              controller.goToAnotherPage(index);
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(
              color: Colors.orange,
            ),
            selectedLabelStyle: const TextStyle(
              color: Colors.orange,
            ),
            selectedFontSize: 9.0,
            unselectedFontSize: 9.0,
            iconSize: 9,
            selectedItemColor: ColorHelper.orange,
            selectedIconTheme: const IconThemeData(color: ColorHelper.orange),
            currentIndex: controller.selectedPageIndex.value,
            items: _bottomNavItems
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: Image.asset(
                      item.iconImage,
                      scale: 2.0,
                      color: item.index == controller.selectedPageIndex.value
                          ? ColorHelper.orange
                          : Colors.grey,
                    ),
                    label: item.name,
                  ),
                )
                .toList(),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}

class BottomNavIconData {
  final int index;
  final String name;
  final String iconImage;

  BottomNavIconData(this.index, {required this.name, required this.iconImage});
}
