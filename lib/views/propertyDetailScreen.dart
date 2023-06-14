import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/sqfliteController.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/utills/customColors.dart';
import 'package:photo_view/photo_view.dart';

class PropertyDetail extends StatelessWidget {
  final PropertyModel data;

  PropertyDetail({required this.data});

  final CurrentUserInfoController controller =
      Get.put(CurrentUserInfoController());
  final SqfliliteController sqfliliteController =
      Get.put(SqfliliteController());
  @override
  Widget build(BuildContext context) {
    sqfliliteController.getLIkiedOnly(data.docId);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    children: [
                      PageView(
                        onPageChanged: (index) {
                          controller.selectedIndex.value = index;
                        },
                        scrollDirection: Axis.horizontal,
                        children: data.images.map((e) {
                          return Hero(
                            tag: e,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      backgroundColor: Colors.black,
                                      body: PhotoView(
                                        imageProvider: NetworkImage(e),
                                        backgroundDecoration:
                                            BoxDecoration(color: Colors.black),
                                        loadingBuilder: (context, event) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator()),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: e,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // Positioned(
                      //   top: 5,
                      //   right: 5,
                      //   child: Obx(() {
                      //     return Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.black26,
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(5.0),
                      //         child: IconButton(
                      //           icon: Icon(
                      //             Icons.favorite,
                      //             color:
                      //                 sqfliliteController.isLiked.value == true
                      //                     ? CustomColors.orangeColor
                      //                     : Colors.white,
                      //           ),
                      //           onPressed: () async {
                      //             sqfliliteController.likePropertyModel
                      //                 .likeProprtyId = data.docId;

                      //             String res = await sqfliliteController
                      //                 .sqfliteService
                      //                 .addToLike(sqfliliteController
                      //                     .likePropertyModel);

                      //             if (res == 'added') {
                      //               print("added");
                      //             } else {
                      //               print("removed");
                      //             }

                      //             sqfliliteController.getLIkiedOnly(data.docId);
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //   }),
                      // ),
                    ],
                  ),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: data.images.map((e) {
                      int index = data.images.indexOf(e);
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: controller.selectedIndex.value == index
                                ? CustomColors.orangeColor
                                : Colors.black54,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    data.address,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    data.descr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                  child: Text(
                    'Listing Agent',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.orangeColor,
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isLoading.value == true) {
                    return CircularProgressIndicator();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, right: 15, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data.bathrooms,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Text(data.bedrooms),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              FlutterPhoneDirectCaller.callNumber(
                                  data.bedrooms);
                            },
                            icon: Icon(Icons.phone),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
