import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/controllers/rentAndRentOutController.dart';
import 'package:haider/controllers/searchRentController.dart';
import 'package:haider/models/propertyModel.dart';
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
    return Scaffold(
      body: Obx(() {
        if (rentAndRentOutController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final List<PropertyModel> properties =
              rentAndRentOutController.allRentList;
          if (properties.isEmpty) {
            return Center(
              child: Text(
                'لا توجد خدمات',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.orangeColor,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    rentAndRentOutController.value.value
                        ? Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: properties.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 1.07,
                                ),
                                itemBuilder: (context, index) {
                                  return buildPropertyCard(
                                    context,
                                    properties[index],
                                  );
                                },
                              ),
                            ],
                          )
                        : Obx(() {
                            if (searchRentController.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              final List<PropertyModel> searchResults =
                                  searchRentController.rentSerachList;
                              if (searchResults.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No Data Found',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.orangeColor,
                                    ),
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: searchResults.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        MediaQuery.of(context).size.height /
                                            1100,
                                  ),
                                  itemBuilder: (context, index) {
                                    return buildPropertyCard(
                                      context,
                                      searchResults[index],
                                    );
                                  },
                                );
                              }
                            }
                          }),
                  ],
                ),
              ),
            );
          }
        }
      }),
    );
  }

  Widget buildPropertyCard(BuildContext context, PropertyModel property) {
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
        onTap: () {
          userInfoController.Id.value = property.currentUserId;
          Get.to(() => PropertyDetail(data: property));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(property.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.address,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    property.descr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${property.city[0].toUpperCase()}${property.city.substring(1).toLowerCase()}',
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
  }
}

class PropertySearchDelegate extends SearchDelegate {
  final SearchRentController searchRentController =
      Get.put(SearchRentController());

  @override
  String get searchFieldLabel => 'ابحث باسم الخدمه';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query = '';
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'لو سمحت ادخل كلمه البحث',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColors.orangeColor,
          ),
        ),
      );
    } else {
      searchRentController.cityEditTextController.value = query;
      return Obx(() {
        if (searchRentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final List<PropertyModel> searchResults =
              searchRentController.rentSerachList;
          if (searchResults.isEmpty) {
            return Center(
              child: Text(
                'لا توجد خدمات بهذا الاسم',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.orangeColor,
                ),
              ),
            );
          } else {
            return GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: searchResults.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.07,
              ),
              itemBuilder: (context, index) {
                final PropertyModel property = searchResults[index];
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
                    onTap: () {
                      Get.put(CurrentUserInfoController()).Id.value =
                          property.currentUserId;
                      Get.to(() => PropertyDetail(data: property));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(property.images[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.address,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                property.descr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${property.city[0].toUpperCase()}${property.city.substring(1).toLowerCase()}',
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
              },
            );
          }
        }
      });
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: ListTile(),
    );
  }
}
