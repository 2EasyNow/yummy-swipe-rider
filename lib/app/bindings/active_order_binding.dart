import 'package:get/get.dart';
import '../controllers/active_order_controller.dart';

class ActiveOrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ActiveOrderController>(ActiveOrderController());
  }
}
