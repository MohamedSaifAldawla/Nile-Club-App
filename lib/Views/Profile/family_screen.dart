import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controllers/profile_controller.dart';
import '../../Models/services.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../size_config.dart';
import '../../theme.dart';

class FamilyScreen extends StatefulWidget {
  FamilyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  Map<String, dynamic> _familyData = {};
  final List<String> errors = [];
  String gender = 'Male';
  DateTime selectedDate = DateTime.now();
  String? personalImg = '';
  String? personalId = '';
  String? pImag64;
  String? pId64;
  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title: Text("Add family members".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 30),
          child: Form(
            key: profileController.formKey2,
            child: Center(
              child: Column(
                children: [
                  InputField(
                    controller: profileController.fullnameController,
                    label: "Fullname".tr,
                    hint: "Enter your Fullname".tr,
                    type: "fullname",
                    icon: "assets/icons/User.svg",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your Fullname".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Fullname".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Fullname".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                  const Gap(25),
                  InputField(
                    controller: profileController.phoneController,
                    label: "Phone".tr,
                    hint: "Enter your Phone".tr,
                    type: "Phone",
                    icon: "assets/icons/Phone.svg",
                    obscureText: false,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your Phone".tr);
                      }
                      if (value!.length >= 10) {
                        removeError(error: "Phone number is too short".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Phone".tr);
                      }

                      if (value.length < 10) {
                        addError(error: "Phone number is too short".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Phone".tr);
                        return "";
                      } else if (value.length < 10) {
                        addError(error: "Phone number is too short".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: getProportionateScreenHeight(60),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kSecondaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BodyText(
                              text: "Date of birth".tr,
                              color: kSecondaryColor,
                            ),
                            Spacer(),
                            BodyText(
                              text:
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                              color: kSecondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  InkWell(
                    onTap: () {
                      picPersonalImage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: getProportionateScreenHeight(60),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kSecondaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BodyText(
                              text: "Upload Personal Photo".tr,
                              color: kSecondaryColor,
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              "assets/icons/Cloud.svg",
                              width: getProportionateScreenWidth(25),
                              height: getProportionateScreenHeight(25),
                              color: kSecondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: personalImg == ''
                        ? BodyText(
                            text: "Personal Photo not selected".tr,
                            color: kTextColor,
                            maxLines: 3,
                          )
                        : BodyText(
                            text: "${personalImg}",
                            color: kTextColor,
                            maxLines: 3,
                          ),
                  ),
                  const Gap(25),
                  InkWell(
                    onTap: () {
                      picIdImage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: getProportionateScreenHeight(60),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kSecondaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BodyText(
                              text: "Upload Personal identification".tr,
                              color: kSecondaryColor,
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              "assets/icons/Cloud.svg",
                              width: getProportionateScreenWidth(25),
                              height: getProportionateScreenHeight(25),
                              color: kSecondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: personalImg == ''
                        ? BodyText(
                            text: "Personal ID not selected".tr,
                            color: kTextColor,
                            maxLines: 3,
                          )
                        : BodyText(
                            text: "${personalId}",
                            color: kTextColor,
                            maxLines: 3,
                          ),
                  ),
                  const Gap(25),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        BodyText(
                          text: "Gender".tr,
                          color: kTextColor,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text("Male".tr),
                          value: "Male",
                          groupValue: gender,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(
                              () {
                                gender = value.toString();
                                print(gender);
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text("Female".tr),
                          value: "Female",
                          groupValue: gender,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                              print(gender);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  FormError(errors: errors),
                  const Gap(20),
                  PrimaryButton(
                    text: "submit form".tr,
                    press: () {
                      if (profileController.formKey2.currentState!.validate()) {
                        if (personalImg == '' ||
                            personalId == '' ||
                            pImag64 == '' ||
                            pId64 == '') {
                          addError(
                              error: "Please upload your personal photo and id"
                                  .tr);
                        } else if (personalImg != '' &&
                            personalId != '' &&
                            pImag64 != '' &&
                            pId64 != '') {
                          removeError(
                              error: "Please upload your personal photo and id"
                                  .tr);
                          _familyData['type'] =
                              profileController.membershipType;
                          _familyData['name'] =
                              profileController.fullnameController.text;
                          _familyData['phone'] =
                              profileController.phoneController.text;
                          _familyData['dofb'] = selectedDate;
                          _familyData['gender'] = gender;
                          _familyData['img'] = personalImg;
                          _familyData['pid'] = personalId;
                          _familyData['img64'] = pImag64;
                          _familyData['pid64'] = pId64;
                          profileController.AddFamily(familyData: _familyData);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: selectedDate,
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        print(selectedDate);
      });
  }

  Future picPersonalImage() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(
      () {
        File file = File(myfile!.path);
        if (file == null) return;
        pImag64 = base64Encode(file.readAsBytesSync());
        personalImg = file.path.split('/').last;
      },
    );
  }

  Future picIdImage() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(
      () {
        File file = File(myfile!.path);
        if (file == null) return;
        pId64 = base64Encode(file.readAsBytesSync());
        personalId = file.path.split('/').last;
      },
    );
  }

  //--------------------- Snack Bar --------------------------//
  SnackbarController SnackBar(String title, String message, Widget icon,
      Color backgroundColor, SnackPosition? snackPosition) {
    return Get.snackbar(
      title,
      message,
      icon: icon,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      borderRadius: 20,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
} //end of controller

