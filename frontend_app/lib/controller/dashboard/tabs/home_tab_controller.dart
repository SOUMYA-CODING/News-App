import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeTabController extends GetxController {
  static HomeTabController get instance => Get.find();

  RxString formattedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateDate();
  }

  void updateDate() {
    final now = DateTime.now();
    final day = DateFormat("d").format(now);
    final month = DateFormat("MMMM").format(now);
    final daySuffix = _getDaySuffix(int.parse(day));
    formattedDate.value = "Today, $day$daySuffix $month";
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
