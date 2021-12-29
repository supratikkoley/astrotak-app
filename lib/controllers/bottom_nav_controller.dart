import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedPageIndex = 0.obs;
  
  void goToAnotherPage(int index) {
    selectedPageIndex.value = index;
  }
}
