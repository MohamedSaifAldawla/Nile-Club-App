import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../Controllers/profile_controller.dart';
import '../../Models/services.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../size_config.dart';
import '../../theme.dart';

class AddNewMemberScreen extends StatefulWidget {
  AddNewMemberScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewMemberScreen> createState() => _AddNewMemberScreenState();
}

class _AddNewMemberScreenState extends State<AddNewMemberScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  final Map<String, dynamic> _subscribeData = {};
  final List<String> errors = [];
  String gender = 'Male';
  String months = '';
  String personType = 'Adult';
  String membershipStatus = 'New';
  DateTime selectedDate = DateTime.now();
  String? personalImg = '';
  String? personalId = '';
  String? pImag64;
  String? pId64;
  double? maxWidth = 1800;
  double? maxHeight = 1800;
  int? imageQuality = 70;

  final List<String> monthsItems = [
    'Month'.tr,
    '3 Months'.tr,
    '6 Months'.tr,
    '12 Months'.tr
  ];
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
        title: Text("Add Member".tr),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
          child: Form(
            key: profileController.formKey,
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // profileController.fullnameController.text = "moesaif12";
                      // profileController.phoneController.text = "5555555555";
                      // profileController.emailController.text = "M@m.com";
                      // profileController.addressController.text = "khartoum";
                      // profileController.occupController.text = "Worker";
                    },
                    child: ScreenTitle(text: "Membership Join".tr),
                  ),
                  const Gap(5),
                  BodyText(
                    text:
                        "Please complete the form below to join our membership"
                            .tr,
                    maxLines: 2,
                  ),
                  const Gap(30),
                  if (profileController.membershipType == "Family")
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          BodyText(
                            text: "Person type".tr,
                            color: kSecondaryColor,
                          ),
                        ],
                      ),
                    ),
                  if (profileController.membershipType == "Family")
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text("Adult".tr),
                            value: "Adult",
                            groupValue: personType,
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  personType = value.toString();
                                  profileController.occupController.text = "";
                                  print(personType);
                                },
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text("Child".tr),
                            value: "Child",
                            groupValue: personType,
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  personType = value.toString();
                                  profileController.occupController.text = "";
                                  removeError(
                                      error: "Please Enter occupation".tr);

                                  print(personType);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  if (GetStorage().read('formid') == "null")
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          BodyText(
                            text: "Membership status".tr,
                            color: kSecondaryColor,
                          ),
                        ],
                      ),
                    ),
                  if (GetStorage().read('formid') == "null")
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text("New".tr),
                            value: "New",
                            groupValue: membershipStatus,
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  membershipStatus = value.toString();
                                  months = "";
                                  profileController
                                      .membershipIdController.text = "";
                                  removeError(
                                      error:
                                          "Please Enter your Membership ID".tr);
                                  print(membershipStatus);
                                },
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text("Exist".tr),
                            value: "Exist",
                            groupValue: membershipStatus,
                            activeColor: kPrimaryColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  membershipStatus = value.toString();
                                  months = "";
                                  profileController
                                      .membershipIdController.text = "";
                                  removeError(error: "Please select".tr);
                                  print(membershipStatus);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  const Gap(10),
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
                    controller: profileController.addressController,
                    label: "Address".tr,
                    hint: "Enter your Address".tr,
                    type: "Address",
                    icon: "assets/icons/Address.svg",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    height: getProportionateScreenWidth(20),
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your address".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your address".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your address".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                  const Gap(25),
                  InputField(
                    controller: profileController.emailController,
                    label: "Email".tr,
                    hint: "Enter your email".tr,
                    type: "email",
                    icon: "assets/icons/Mail.svg",
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Enter your email".tr);
                      }
                      if (emailValidatorRegExp.hasMatch(value!)) {
                        removeError(error: "Please Enter Valid Email".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Enter your email".tr);
                      }
                      if (!emailValidatorRegExp.hasMatch(value)) {
                        addError(error: "Please Enter Valid Email".tr);
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Enter your email".tr);
                        return "";
                      } else if (!emailValidatorRegExp.hasMatch(value)) {
                        addError(error: "Please Enter Valid Email".tr);
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
                  if (personType == "Adult")
                    InputField(
                      controller: profileController.occupController,
                      label: "Occupation".tr,
                      hint: "Enter your Occupation".tr,
                      type: "Occupation",
                      icon: "assets/icons/Job.svg",
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      height: getProportionateScreenWidth(20),
                      onChanged: (value) {
                        if (personType == "Adult") {
                          if (value == null || value.isEmpty) {
                            addError(error: "Please Enter occupation".tr);
                          }
                          if (value == null || value.isNotEmpty) {
                            removeError(error: "Please Enter occupation".tr);
                          }
                        }
                        return null;
                      },
                      validator: (value) {
                        if (personType == "Adult") {
                          if (value == null || value.isEmpty) {
                            addError(error: "Please Enter occupation".tr);
                            return "";
                          }
                        }
                        return null;
                      },
                    ),
                  const Gap(25),
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
                  const Gap(25),
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
                  BodyText(
                    text: "Upload Personal background".tr,
                    color: kTextColor,
                    maxLines: 2,
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
                  const Gap(20),
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
                    child: personalId == ''
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
                  const Gap(20),
                  if (GetStorage().read('formid') == "null" &&
                      membershipStatus == "New")
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: Text(
                        'Number of months'.tr,
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: monthsItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            removeError(error: "Please select".tr);
                            switch (value) {
                              case "Month":
                                months = "1";
                                break;
                              case "3 Months":
                                months = "3";
                                break;
                              case "6 Months":
                                months = "6";
                                break;
                              case "12 Months":
                                months = "12";
                                break;
                              default:
                            }

                            //months = value.toString();
                            print(months);
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null) {
                          if (membershipStatus == "New") {
                            addError(error: "Please select".tr);
                            return "";
                          }
                        }
                      },
                    ),
                  const Gap(25),
                  if (membershipStatus == "Exist")
                    InputField(
                      controller: profileController.membershipIdController,
                      label: "Membership ID".tr,
                      hint: "Enter your membership ID".tr,
                      type: "MembershipID",
                      icon: "assets/icons/DebitCard.svg",
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        if (value == null || value.isNotEmpty) {
                          removeError(
                              error: "Please Enter your Membership ID".tr);
                        }
                        if (value == null || value.isEmpty) {
                          addError(error: "Please Enter your Membership ID".tr);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: "Please Enter your Membership ID".tr);
                          return "";
                        }
                        return null;
                      },
                    ),
                  const Gap(25),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        BodyText(
                          text: "Gender".tr,
                          color: kSecondaryColor,
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
                            setState(
                              () {
                                gender = value.toString();
                                print(gender);
                              },
                            );
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
                      if (profileController.formKey.currentState!.validate()) {
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
                          if (GetStorage().read('formid') != "null") {
                            membershipStatus == '';
                          }
                          _subscribeData['type'] = personType;
                          _subscribeData['name'] =
                              profileController.fullnameController.text;
                          _subscribeData['address'] =
                              profileController.addressController.text;
                          _subscribeData['phone'] =
                              profileController.phoneController.text;
                          _subscribeData['occup'] =
                              profileController.occupController.text;
                          _subscribeData['email'] =
                              profileController.emailController.text;
                          _subscribeData['dofb'] = selectedDate;
                          _subscribeData['gender'] = gender;
                          _subscribeData['months'] = months;
                          _subscribeData['membership_status'] =
                              membershipStatus;
                          _subscribeData['membership_id'] =
                              profileController.membershipIdController.text;
                          _subscribeData['ticket_id'] =
                              "${profileController.membershipReserve["ticket_type_id"]}";
                          _subscribeData['img'] = personalImg;
                          _subscribeData['pid'] = personalId;
                          _subscribeData['img64'] = pImag64;
                          _subscribeData['pid64'] = pId64;
                          profileController.Subscribe(
                                  subscribeData: _subscribeData)
                              .then(
                            (value) => {
                              setState(
                                () {
                                  personalImg = '';
                                  personalId = '';
                                  GetStorage().read('formid');
                                  membershipStatus = 'none';
                                },
                              )
                            },
                          );
                        }
                      }
                    },
                  ),
                  const Gap(30),
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
    final myfile = await ImagePicker().pickImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      source: ImageSource.gallery,
    );
    try {
      setState(
        () {
          File file = File(myfile!.path);
          if (file == null) return;
          pImag64 = base64Encode(file.readAsBytesSync());
          final bytes = file.readAsBytesSync().lengthInBytes;
          personalImg = file.path.split('/').last;
          print("pImage64 : $pImag64");
          print("personalImg : $personalImg");
          print("bytes : $bytes");
        },
      );
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future picIdImage() async {
    final myfile = await ImagePicker().pickImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      source: ImageSource.gallery,
    );
    try {
      setState(
        () {
          File file = File(myfile!.path);
          if (file == null) return;
          pId64 = base64Encode(file.readAsBytesSync());
          final bytes = file.readAsBytesSync().lengthInBytes;
          personalId = file.path.split('/').last;
          print("pId64 : $pId64");
          print("personalId : $personalId");
          print("bytes : $bytes");
        },
      );
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
} //end of controller


























                  // const Gap(10),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30, right: 30),
                  //   child: Row(
                  //     children: [
                  //       BodyText(
                  //         text: "Number of month".tr,
                  //         color: kSecondaryColor,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: RadioListTile(
                  //         title: Text("Month".tr),
                  //         value: "1",
                  //         groupValue: months,
                  //         activeColor: kPrimaryColor,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               months = value.toString();
                  //               print(months);
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: RadioListTile(
                  //         title: Text("3 Month".tr),
                  //         value: "3",
                  //         groupValue: months,
                  //         activeColor: kPrimaryColor,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               months = value.toString();
                  //               print(months);
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: RadioListTile(
                  //         title: Text("6 Month".tr),
                  //         value: "6",
                  //         groupValue: months,
                  //         activeColor: kPrimaryColor,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               months = value.toString();
                  //               print(months);
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: RadioListTile(
                  //         title: Text("12 Month".tr),
                  //         value: "12",
                  //         groupValue: months,
                  //         activeColor: kPrimaryColor,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               months = value.toString();
                  //               print(months);
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),