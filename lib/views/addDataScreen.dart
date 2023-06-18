import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/addpropertyController.dart';
import 'package:haider/controllers/catogryconroller.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/getSellAndBuyPropertController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/customToast.dart';
import 'package:haider/views/chossetype.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../controllers/citycontroller.dart';

class AddDataScreen extends StatelessWidget {
  final String value;

  AddDataScreen({required this.value});

  final box = GetStorage();

  final AddPropertyController controller = Get.put(AddPropertyController());

  final GetSellAndBuyPropertyController sellPropertyController =
      Get.put(GetSellAndBuyPropertyController());

  final RentAndRentOutController rentAndRentOutController = Get.find();

  final CurrentUserInfoController currentUserInfoController =
      Get.put(CurrentUserInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: controller.propertyFormKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Service'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.orangeColor,
                    fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enter Service details to listed on Services'.tr,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Service Name'.tr,
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.greyColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 2),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.addressEditTextController,
              keyboardType: TextInputType.text,
              cursorColor: CustomColors.orangeColor,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: '',
                focusedErrorBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                errorBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                labelText: 'Enter your Service'.tr,
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.work,
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == '' || value == null) return 'Address  required';
              },
              onSaved: (value) {
                controller.propertyModel.address = value.toString();
                //authController.userModel.userEmail = value.toString();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Type of Service'.tr,
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.greyColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() {
            return GestureDetector(
              onTap: () => showService(context),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColors.orangeColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.hail,
                            color: Colors.black54,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${Get.put(AddPropertyController()).selectedValue}"
                                  .tr,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showService(context);
                              },
                              icon: Icon(Icons.arrow_drop_down))
                        ],
                      ),
                    ))),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select City'.tr,
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.greyColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() {
            return GestureDetector(
              onTap: () => showCitiesListDialog(context),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColors.orangeColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_city_outlined,
                            color: Colors.black54,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${controller.selectedCity.value[0].toUpperCase()}${controller.selectedCity.value.substring(1).toLowerCase()}',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showCitiesListDialog(context);
                              },
                              icon: Icon(Icons.arrow_drop_down))
                        ],
                      ),
                    ))),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Area'.tr,
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.greyColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 2),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.areaEditTextController,
              keyboardType: TextInputType.text,
              cursorColor: CustomColors.orangeColor,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: '',
                focusedErrorBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                errorBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                labelText: 'Area'.tr,
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == '' || value == null) return 'Area  required';
              },
              onSaved: (value) {
                controller.propertyModel.area = value.toString();
                //authController.userModel.userEmail = value.toString();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description'.tr,
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.greyColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 2),
            child: TextFormField(
              maxLines: 5,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.desEditTextController,
              keyboardType: TextInputType.text,
              cursorColor: CustomColors.orangeColor,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: '',
                focusedErrorBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                errorBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide:
                        new BorderSide(color: CustomColors.orangeColor)),
                labelText: 'Description'.tr,
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) {
                if (value == '' || value == null)
                  return 'Detailed Description required';
              },
              onSaved: (value) {
                controller.propertyModel.descr = value.toString();

                //authController.userModel.userEmail = value.toString();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 40),
                    primary: CustomColors.orangeColor),
                child: Text("Select Images".tr),
                onPressed: () {
                  controller.getImage();
                }),
          ),
          Obx(() {
            return controller.images.value.isEmpty
                ? Container(
                    height: 0,
                    width: 0,
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 22, right: 22, top: 8),
                    child: GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(controller.images.value.length,
                          (index) {
                        Asset asset = controller.images.value[index];
                        print(asset.getByteData(quality: 100));
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: AssetThumb(
                              asset: asset,
                              width: 300,
                              height: 300,
                            ),
                          ),
                        );
                      }),
                    ),
                  );
          }),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.showLoadingBar == false
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          backgroundColor: CustomColors.lioghtGrey),
                      child: Text("Save Property".tr),
                      onPressed: () async {
                        if (controller.images.value.isEmpty) {
                          CustomToast.showToast('Please Select images');
                        } else {
                          if (!controller.propertyFormKey.currentState!
                              .validate()) {
                            return;
                          } else {
                            controller.propertyModel.city =
                                controller.selectedCity.value;
                            controller.propertyModel.propertyType =
                                controller.selectedValue.value;
                            controller.propertyFormKey.currentState!.save();
                            controller.showLoadingBar(true);
                            String response = await controller.firestoreService
                                .addproprtyToDatabase(controller.propertyModel,
                                    controller.images.value, value);
                            if (response == 'Data added') {
                              controller.showLoadingBar(false);
                              // CustomToast.showToast('Proprty Added');
                              Get.showSnackbar(GetSnackBar(
                                message: 'Proprty Added',
                                duration: Duration(milliseconds: 300),
                              ));
                              sellPropertyController
                                  .getSellProprtyOfCurrentUser();

                              rentAndRentOutController.getAllRentProperty();

                              rentAndRentOutController
                                  .getRentOutProprtyOfCurrentUser();

                              sellPropertyController.getAllBuyingProperty();
                              // currentUserInfoController.getUserInfo();
                              controller.areaEditTextController.clear();
                              controller.addressEditTextController.clear();
                              controller.sizeEditTextController.clear();
                              controller.bedroomsEditTextController.clear();
                              controller.bathroomsTextController.clear();
                              controller.kitchenEditTextController.clear();
                              controller.desEditTextController.clear();
                              controller.priceEditTextController.clear();
                              controller.images.value = [];
// Set the value of pageViewIndex to the index of the page that you want to show

                              Get.offAll(() => Choosetype());
                            } else {
                              controller.showLoadingBar(false);
                              Get.showSnackbar(GetSnackBar(
                                message: 'Something went wrong',
                              ));
                              // CustomToast.showToast('Something went wrong');
                            }
                          }
                        }
                      })
                  : CircularProgressIndicator(
                      color: CustomColors.orangeColor,
                    ),
            );
          }),
          SizedBox(
            height: 50,
          )
        ],
      ),
    )));
  }

  Future<void> showCitiesListDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
              'Select City'.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                Text(""),
                Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: Get.put(CityController()).cityList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: InkWell(
                            onTap: () {
                              String cityName = Get.put(CityController())
                                  .cityList[index]
                                  .cityname!
                                  .tr;
                              Get.put(AddPropertyController())
                                  .selectedCity
                                  .value = cityName;
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${Get.put(CityController()).cityList[index].cityname!.tr}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Icon(
                                    Icons.location_city,
                                    color: CustomColors.orangeColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
              ],
            )));
      },
    );
  }

  Future<void> showService(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Get.put(AddPropertyController);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Select Service'.tr,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Obx(() {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: Get.put(catogryController()).catogryList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            String valName = Get.put(catogryController())
                                .catogryList[index]
                                .catogryname!
                                .tr;
                            Get.put(AddPropertyController())
                                .selectedValue
                                .value = valName;
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${Get.put(catogryController()).catogryList[index].catogryname!.tr}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Icon(
                                  Icons.design_services,
                                  color: CustomColors.orangeColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
        );
      },
    );
  }
}

// showDialog(
//   context: context,
//   builder: (context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose a service',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 3 / 2,
//                 mainAxisSpacing: 16.0,
//                 crossAxisSpacing: 16.0,
//               ),
//               itemCount: controller.values.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     String serviceName = controller.values[index];
//                     controller.selectedValue.value = serviceName;
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 4.0,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.work,
//                           color: CustomColors.orangeColor,
//                         ),
//                         SizedBox(width: 16.0),
//                         Expanded(
//                           child: Text(
//                             '${controller.values[index]}',
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );
