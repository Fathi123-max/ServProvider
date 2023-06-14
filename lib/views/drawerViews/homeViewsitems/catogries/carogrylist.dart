import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';

import '../../../../utills/customColors.dart';
import '../../../propertyDetailScreen.dart';

class catogrylist extends StatelessWidget {
  // const RentOutView({Key key}) : super(key: key);
  final RentAndRentOutController rentOutController =
      Get.put(RentAndRentOutController());

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.extent(
      maxCrossAxisExtent: 200,
      padding: EdgeInsets.all(10),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _buildServiceCategory('Color Man'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Mecanical'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Ground Man'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Plumbing'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Electrician'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Carpentry'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Gardening'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Cleaning Houses'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Blacksmith'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Tiling'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Teacher'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Chef'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Driver'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Nurse'.tr, "assets/images/logo.png"),
        _buildServiceCategory('Baby setter'.tr, "assets/images/logo.png"),
      ],
    ));
  }
}

Widget _buildServiceCategory(String name, String image) {
  return InkWell(
    onTap: () {
      Get.to(() => catogryView(
            name: name,
          ));
      // handle category selection
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 100,
            width: 100,
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class catogryView extends StatefulWidget {
  catogryView({super.key, this.name});
  String? name;

  @override
  State<catogryView> createState() => _catogryViewState();
}

class _catogryViewState extends State<catogryView> {
  final RentAndRentOutController rentOutController =
      Get.put(RentAndRentOutController());

  @override
  void initState() {
    rentOutController.getAllRentPropertyByCatogry(widget.name!);
  }

  @override
  Widget build(BuildContext context) {
    final RentAndRentOutController rentOutController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new)),
        elevation: 0.0,
      ),
      body: Obx(() {
        if (rentOutController.isLoading == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          return rentOutController.allcatList.value.length == 0
              ? Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.orangeColor),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: rentOutController.allcatList.value.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, childAspectRatio: 1.07),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: InkWell(
                            splashColor: Colors.green,
                            onTap: () {
                              Get.to(() => PropertyDetail(
                                  data: rentOutController.allcatList[index]));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(rentOutController
                                          .allcatList[index].images[0]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rentOutController
                                            .allcatList[index].address,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        rentOutController
                                            .allcatList[index].descr,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${rentOutController.allcatList[index].city[0].toUpperCase()}${rentOutController.allcatList[index].city.substring(1).toLowerCase()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
        }
      }),
    );
  }
}






/**    Container(
          child: TextField(
            controller: textEditingController,
            onSubmitted: (value5) {
              print(value5);
              print("............................................");
              rentOutController.getAllRentPropertyByCatogry(value5);
              print(rentOutController.getAllRentPropertyByCatogry(value5));
            },
          ),
        ), */
