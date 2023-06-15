import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/controllers/searchRentController.dart';
import 'package:haider/utills/customColors.dart';

import '../../propertyDetailScreen.dart';

class RentView extends StatelessWidget {
  final RentAndRentOutController rentAndRentOutController =
      Get.put(RentAndRentOutController());
  final CurrentUserInfoController userInfoController =
      Get.put(CurrentUserInfoController());
  final SearchRentController searchRentController =
      Get.put(SearchRentController());
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (rentAndRentOutController.isLoading == true) {
        return Center(child: CircularProgressIndicator());
      } else {
        return rentAndRentOutController.allRentList.value.length == 0
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      rentAndRentOutController.value.value == true
                          ? Column(
                              children: [
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: rentAndRentOutController
                                        .allRentList.value.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            childAspectRatio: 1.07),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(20),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            userInfoController.Id.value =
                                                rentAndRentOutController
                                                    .allRentList[index]
                                                    .currentUserId;
                                            // userInfoController.getUserInfo();
                                            Get.to(() => PropertyDetail(
                                                data: rentAndRentOutController
                                                    .allRentList[index]));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 170,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        rentAndRentOutController
                                                            .allRentList[index]
                                                            .images[0]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      rentAndRentOutController
                                                          .allRentList[index]
                                                          .address,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      rentAndRentOutController
                                                          .allRentList[index]
                                                          .descr,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black54,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      '${rentAndRentOutController.allRentList[index].city[0].toUpperCase()}${rentAndRentOutController.allRentList[index].city.substring(1).toLowerCase()}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                              ],
                            )
                          : Obx(() {
                              if (searchRentController.isLoading.value ==
                                  true) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return searchRentController.rentSerachList.value.length ==
                                        0
                                    ? Center(
                                        child: Text(
                                        'No Data Found',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.orangeColor),
                                      ))
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: searchRentController
                                            .rentSerachList.value.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1100,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 3,
                                              child: InkWell(
                                                  splashColor: Colors.green,
                                                  onTap: () {
                                                    Get.to(() => PropertyDetail(
                                                        data: searchRentController
                                                                .rentSerachList[
                                                            index]));
                                                  },
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Stack(
                                                            children: [
                                                              CachedNetworkImage(
                                                                imageUrl: searchRentController
                                                                    .rentSerachList[
                                                                        index]
                                                                    .images[0],
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  height: 150,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Center(
                                                                        child: Icon(
                                                                            Icons.error)),
                                                              ),
                                                              searchRentController
                                                                          .rentSerachList[
                                                                              index]
                                                                          .action ==
                                                                      'Sold Out'
                                                                  ? Positioned(
                                                                      top: 5,
                                                                      left: 5,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                CustomColors.orangeColor,
                                                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Sold Out',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  : Container(
                                                                      height: 0,
                                                                      width: 0,
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Text(
                                                            searchRentController
                                                                .rentSerachList[
                                                                    index]
                                                                .address,
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Text(
                                                            '${searchRentController.rentSerachList[index].city[0].toUpperCase()}${searchRentController.rentSerachList[index].city.substring(1).toLowerCase()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child: Row(
                                                            //  mainAxisAlignment:
                                                            //   MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Text(
                                                                'Price',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                '${searchRentController.rentSerachList[index].price} Rs',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: CustomColors
                                                                        .orangeColor),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ])));
                                        });
                              }
                            })
                    ],
                  ),
                ),
              );
      }
    }));
  }
}

// class ListViewCategories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RentAndRentOutController>(
//       builder: (controller) => Container(
//         height: 180,
//         child: ListView(scrollDirection: Axis.horizontal, children: [
//           cathome( 'Home'.tr, "assets/images/logo.png"),
//           cathome('Plumbing', "assets/images/logo.png"),
//           cathome('Cleaning', "assets/images/logo.png"),
//           cathome('Gardening', "assets/images/logo.png"),
//         ]),
//       ),
//     );
//   }
// }

// Widget cathome(String name, String image) {
//   return GestureDetector(
//     onTap: () {},
//     child: Container(
//       width: 120,
//       height: 130,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 60,
//             backgroundImage: AssetImage(image),
//           ),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(name),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// class BannerView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(bottom: 16.w),
//       child: Column(
//         children: [
//           CustomText(
//             text: 'Special Offers',
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(height: 16),
//           GetBuilder<RentAndRentOutController>(
//             builder: (controller) => Container(
//               height: 220.h,
//               child: CarouselSlider(
//                 items: controller.offers.map((offer) {
//                   return Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: NetworkImage(offer.image!), fit: BoxFit.fill),
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                   );
//                 }).toList(),
//                 options: CarouselOptions(
//                   height: 220.h,
//                   autoPlay: true,
//                   autoPlayInterval: Duration(seconds: 3),
//                   autoPlayAnimationDuration: Duration(milliseconds: 1000),
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   enableInfiniteScroll: true,
//                   scrollDirection: Axis.horizontal,
//                   onPageChanged: (index, reason) {
//                     // Handle page change here
//                   },
//                   viewportFraction: 1.0,
//                   initialPage: 0,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
