import 'package:deliveryplus/models/routeModel.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final activeTab = 0.obs;
  final activeGender = 0.obs;
  // define loading state.
  final isLoading = false.obs;
  RxList<SearchRoute> localRoutes = <SearchRoute>[].obs;

  void change(state) => isLoading.value = state;
  void updateTab(state) => activeTab.value = state;
  void setLocalRoutes(state) => localRoutes.value = state;
}
