import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/services/firestoreService.dart';
import 'package:haider/utills/customColors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddPropertyController extends GetxController {
  //Variables
  var showLoadingBar = false.obs;
  var selectedCity = 'dammita'.obs;
  // var citieslist = <CityModel>[CityModel("cairo")].obs;
  var citieslist2 = ["cairo", 'dammita', "Farscore"].obs;

  var values = <String>[
    'Home',
    'Appartment',
    "Plumbing",
    "Electrician",
    'Carpentry',
    'Gardening',
    'Cleaning',
    'Plumbing',
    'Electrician',
    'Carpentry',
    'Gardening'
  ].obs;
  var selectedValue = 'Home'.obs;
  var selectedColor = CustomColors.orangeColor.obs;
  var unSelectedColor = CustomColors.greyColor.obs;
  var images = <Asset>[].obs;
  PropertyModel propertyModel = PropertyModel();
  FirestoreService firestoreService = FirestoreService();
  var propertyFormKey = GlobalKey<FormState>();
  final cityEditTextController = TextEditingController();
  var areaEditTextController = TextEditingController();
  var addressEditTextController = TextEditingController();
  var sizeEditTextController = TextEditingController();
  var bedroomsEditTextController = TextEditingController();
  var bathroomsTextController = TextEditingController();
  var kitchenEditTextController = TextEditingController();
  var desEditTextController = TextEditingController();
  var priceEditTextController = TextEditingController();

////////////////////////////////////////////
  //Mathods

  Future getImage() async {
    var image = await MultiImagePicker.pickImages(
        maxImages: 7, enableCamera: true, selectedAssets: images);
    images.value = image;
  }

  // Future<void> getCitiesData() async {
  //   var list = await firestoreService.getcitiesList();
  //   citieslist.value = list;
  // }

  @override
  void onInit() {
    super.onInit();

    // getCitiesData();
  }
}
