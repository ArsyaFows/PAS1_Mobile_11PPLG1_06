import 'package:get/get.dart';
import '../menus/favorite/favoriteController.dart';
import '../menus/profile/profileController.dart';
import '../menus/sport/sportController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportController>(() => SportController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
