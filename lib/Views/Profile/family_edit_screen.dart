import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../Globals/globals.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../Widgets/primary_button.dart';
import '../../size_config.dart';
import '../../theme.dart';

class FamilyEditScreen extends StatefulWidget {
  FamilyEditScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FamilyEditScreen> createState() => _FamilyEditScreenState();
}

class _FamilyEditScreenState extends State<FamilyEditScreen> {
  final Map<String, dynamic> _subscribeData = {};
  late File personalfile;
  late File idfile;
  final List<String> errors = [];

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
        title: Text(profileController.title.text.toUpperCase()),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          child: Form(
            key: profileController.formKey,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      personalImg == ''
                          ? image(
                              imageUrl: profileController.memberImg,
                              onPressed: () => picPersonalImage())
                          : Stack(
                              children: [
                                SizedBox(
                                  width: getProportionateScreenWidth(150),
                                  height: getProportionateScreenWidth(150),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? kPrimaryLightColor
                                            : kPrimaryDark3Color,
                                    backgroundImage: FileImage(personalfile),
                                  ),
                                ),
                                Positioned(
                                  bottom: getProportionateScreenWidth(0),
                                  right: getProportionateScreenWidth(0),
                                  child: Container(
                                    height: getProportionateScreenWidth(40),
                                    width: getProportionateScreenWidth(40),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kSecondaryColor,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        picPersonalImage();
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/Picture.svg",
                                        color: kPrimaryLightColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      const Gap(20),
                      personalId == ''
                          ? image(
                              imageUrl: profileController.memberPidImg,
                              onPressed: () => picIdImage())
                          : Stack(
                              children: [
                                SizedBox(
                                  width: getProportionateScreenWidth(150),
                                  height: getProportionateScreenWidth(150),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? kPrimaryLightColor
                                            : kPrimaryDark3Color,
                                    backgroundImage: FileImage(idfile),
                                  ),
                                ),
                                Positioned(
                                  bottom: getProportionateScreenWidth(0),
                                  right: getProportionateScreenWidth(0),
                                  child: Container(
                                    height: getProportionateScreenWidth(40),
                                    width: getProportionateScreenWidth(40),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kSecondaryColor,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        picIdImage();
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/icons/Picture.svg",
                                        color: kPrimaryLightColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  const Gap(15),
                  BodyText(
                    text: "Upload Personal background".tr,
                    color: kTextColor,
                    maxLines: 2,
                  ),
                  const Gap(30),
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
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text("Adult".tr),
                          value: "Adult",
                          groupValue: profileController.personType,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(
                              () {
                                profileController.personType = value.toString();
                                profileController.occupController.text = "";
                                print(profileController.personType);
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text("Child".tr),
                          value: "Child",
                          groupValue: profileController.personType,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(
                              () {
                                profileController.personType = value.toString();
                                profileController.occupController.text = "";
                                removeError(
                                    error: "Please Enter occupation".tr);

                                print(profileController.personType);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: RadioListTile(
                  //         title: Text("New".tr),
                  //         value: "0",
                  //         groupValue: profileController.membershipStatus,
                  //         activeColor: kPrimaryColor,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               profileController.membershipStatus =
                  //                   value.toString();
                  //               profileController.months = "";
                  //               profileController.membershipIdController.text =
                  //                   "";
                  //               removeError(
                  //                   error:
                  //                       "Please Enter your Membership ID".tr);
                  //               print(profileController.membershipStatus);
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: RadioListTile(
                  //         title: Text("Exist".tr),
                  //         value: "1",
                  //         groupValue: profileController.membershipStatus,
                  //         activeColor: kPrimaryColor,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               profileController.membershipStatus =
                  //                   value.toString();
                  //               profileController.months = "";
                  //               profileController.membershipIdController.text =
                  //                   "";
                  //               removeError(error: "Please select".tr);
                  //               print(profileController.membershipStatus);
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                  if (profileController.personType == "Adult")
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
                        if (profileController.personType == "Adult") {
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
                        if (profileController.personType == "Adult") {
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
                                  "${profileController.selectedDate.day}/${profileController.selectedDate.month}/${profileController.selectedDate.year}",
                              color: kSecondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  if (profileController.userId == profileController.parent)
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
                        profileController.months == null
                            ? 'Number of months'.tr
                            : profileController.months,
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
                                profileController.months = "1";
                                break;
                              case "3 Months":
                                profileController.months = "3";
                                break;
                              case "6 Months":
                                profileController.months = "6";
                                break;
                              case "12 Months":
                                profileController.months = "12";
                                break;
                              default:
                            }

                            print(profileController.months);
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null) {
                          if (profileController.months == "" &&
                              profileController.userId ==
                                  profileController.parent) {
                            addError(error: "Please select".tr);
                            return "";
                          }
                        }
                      },
                    ),
                  const Gap(25),
                  if (profileController.membershipStatus == "1")
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
                          groupValue: profileController.gender,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(
                              () {
                                profileController.gender = value.toString();
                                print(profileController.gender);
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text("Female".tr),
                          value: "Female",
                          groupValue: profileController.gender,
                          activeColor: kPrimaryColor,
                          onChanged: (value) {
                            setState(
                              () {
                                profileController.gender = value.toString();
                                print(profileController.gender);
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
                        _subscribeData['type'] = profileController.personType;
                        _subscribeData['memberId'] = profileController.memberId;
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
                        _subscribeData['dofb'] = profileController.selectedDate;
                        _subscribeData['gender'] = profileController.gender;
                        _subscribeData['months'] = profileController.months;
                        _subscribeData['membership_status'] =
                            profileController.membershipStatus;
                        _subscribeData['membership_id'] =
                            profileController.membershipIdController.text;
                        _subscribeData['img'] = personalImg;
                        _subscribeData['pid'] = personalId;
                        _subscribeData['img64'] = pImag64;
                        _subscribeData['pid64'] = pId64;
                        profileController.EditSubscribe(
                                editSubscribeData: _subscribeData)
                            .then(
                          (value) => {
                            setState(
                              () {
                                personalImg = '';
                                personalId = '';
                              },
                            )
                          },
                        );
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

  CachedNetworkImage image(
      {required String imageUrl, required Function() onPressed}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Loader(),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: 60,
      ),
      imageBuilder: (context, imageProvider) => Stack(
        children: [
          Container(
            width: getProportionateScreenWidth(150.0),
            height: getProportionateScreenWidth(150.0),
            decoration: BoxDecoration(
              color: kTextColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: getProportionateScreenWidth(0),
            right: getProportionateScreenWidth(0),
            child: Container(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kSecondaryColor,
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: SvgPicture.asset(
                  "assets/icons/Picture.svg",
                  color: kPrimaryLightColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: profileController.selectedDate,
      firstDate: DateTime(1900),
      lastDate: profileController.selectedDate,
    );
    if (selected != null && selected != profileController.selectedDate)
      setState(() {
        profileController.selectedDate = selected;
        print(profileController.selectedDate);
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
          personalfile = File(myfile!.path);
          if (personalfile == null) return;
          pImag64 = base64Encode(personalfile.readAsBytesSync());
          final bytes = personalfile.readAsBytesSync().lengthInBytes;
          personalImg = personalfile.path.split('/').last;
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
          idfile = File(myfile!.path);
          if (idfile == null) return;
          pId64 = base64Encode(idfile.readAsBytesSync());
          final bytes = idfile.readAsBytesSync().lengthInBytes;
          personalId = idfile.path.split('/').last;
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



