import 'package:get/get.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';

class SearchRentController extends GetxController {
  var rentSerachList = <PropertyModel>[].obs;
  FirestoreService firestoreService = FirestoreService();
  var isLoading = false.obs;

  final cityEditTextController = "".obs;

  @override
  void onInit() {
    super.onInit();
    ever(cityEditTextController, (_) {
      searchRentList();
    });
  }

  Future<void> searchRentList() async {
    isLoading.value = true;
    var list = await firestoreService.serachRentList(
      cityEditTextController.value,
    );
    rentSerachList.value = list;
    isLoading.value = false;
  }
}
