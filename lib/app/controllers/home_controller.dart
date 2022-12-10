import 'package:get/get.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
  }

  requestLocationPermission() {
    Location location = Location();
    location.requestPermission().then((value) {
      if (value == PermissionStatus.granted) {
        location.getLocation().then((value) {});
      }
    });
  }
}
