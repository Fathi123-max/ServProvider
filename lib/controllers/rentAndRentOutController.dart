import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';

class RentAndRentOutController extends GetxController {
  FirestoreService firestoreService = FirestoreService();
  var currentUserRentOutlist = <PropertyModel>[].obs;
  RxList<PropertyModel> allRentList = <PropertyModel>[].obs;
  RxList<PropertyModel> allcatList = <PropertyModel>[].obs;
  var isLoading = false.obs;
  var value = true.obs;

  final cityEditTextController = TextEditingController();
  final rangeTextFromController = TextEditingController();
  final rangeTextToTextController = TextEditingController();

  getRentOutProprtyOfCurrentUser() async {
    isLoading(true);
    var newList = await firestoreService.getCurrentUserPropertyForRentOut();
    currentUserRentOutlist.value = newList;
    isLoading(false);
  }

  getAllRentProperty() async {
    isLoading(true);
    var newList = await firestoreService.getAllRentList();
    allRentList.value = newList;
    isLoading(false);
  }

  getAllRentPropertyByCatogry(String search) async {
    isLoading(true);
    var catogryByName =
        await firestoreService.getAllRentListByCatogry(search: search);
    allcatList.value = catogryByName;
    isLoading(false);
  }

  @override
  void onInit() {
    super.onInit();
    getRentOutProprtyOfCurrentUser();
    getAllRentProperty();
  }

  @override
  void onClose() {
    // Dispose of the text editing controllers
    cityEditTextController.dispose();
    rangeTextFromController.dispose();
    rangeTextToTextController.dispose();
    super.onClose();
  }
}
