import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/views/drawerViews/homeView.dart';

import '../controllers/currentUserInfoController.dart';
import '../utills/customColors.dart';

class EnterInfo extends StatefulWidget {
  @override
  State<EnterInfo> createState() => _EnterInfoState();
}

class _EnterInfoState extends State<EnterInfo> {
  final box = GetStorage();

  final controller = Get.put(CurrentUserInfoController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.gif'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ادخل بياناتك من فضلك",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    labelText: 'Name'.tr,
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null) ;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    labelText: 'Phone'.tr,
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null) ;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                child: InkWell(
                  onTap: () {
                    final String name = _nameController.text.trim();
                    final String phone = _phoneController.text.trim();

                    // if (name.isEmpty || phone.isEmpty) {
                    //   Get.dialog(AlertDialog(
                    //       icon: Icon(Icons.error),
                    //       content: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Text("ادخل بياناتك من فضلك"),
                    //           ])));
                    //   return;
                    // }

                    final bool isNameValid =
                        RegExp(r'^[a-zA-Z\u0621-\u064A ]+$').hasMatch(name);
                    final bool isPhoneValid =
                        RegExp(r'^[0-9]+$').hasMatch(phone);

                    if (!isNameValid) {
                      Get.dialog(AlertDialog(
                          icon: Icon(Icons.error),
                          content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("يرجى إدخال اسم صالح"),
                              ])));
                      return;
                    }

                    if (!isPhoneValid) {
                      Get.dialog(AlertDialog(
                          icon: Icon(Icons.error),
                          content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("يرجى إدخال رقم هاتف صالح"),
                              ])));
                      return;
                    }

                    box.write('name', name);
                    box.write('phone', phone);
                    Get.offAll(() => Home());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.lioghtGrey,
                      border: Border.all(color: CustomColors.lioghtGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Next'.tr,
                        style: TextStyle(color: CustomColors.greyColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }
}
