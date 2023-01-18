import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Widgets/primary_button.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Globals/globals.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../size_config.dart';
import 'package:nile_club/Controllers/auth_controller.dart';

import '../../theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? lastname;
  String? email;
  String? firstname;
  String? phone;
  String? password;
  String? confirm;

  bool _hidePassword = true;
  final List<String> errors = [];
  Map<String, dynamic> _registerData = {};

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
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Register".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FadeAnimation(
                  1,
                  ScreenTitle(text: "Register New Account".tr),
                ),
                const Gap(5),
                FadeAnimation(
                  1.1,
                  BodyText(text: "Complete yor details".tr),
                ),
                const Gap(30),
                FadeAnimation(
                  1.2,
                  InputField(
                    controller: _firstnameController,
                    label: "Firstname".tr,
                    hint: "Enter your First name".tr,
                    type: "firstname",
                    icon: "assets/icons/User.svg",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => firstname = newValue,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your First name".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your First name".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your First name".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(25),
                FadeAnimation(
                  1.3,
                  InputField(
                    controller: _lastnameController,
                    label: "Last name".tr,
                    hint: "Enter your Last name".tr,
                    type: "Lastname",
                    icon: "assets/icons/User.svg",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => lastname = newValue,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your Last name".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Last name".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Last name".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(25),
                FadeAnimation(
                  1.4,
                  InputField(
                    controller: _phoneController,
                    label: "Phone".tr,
                    hint: "Enter your Phone".tr,
                    type: "Phone",
                    icon: "assets/icons/Phone.svg",
                    obscureText: false,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => phone = newValue,
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
                ),
                const Gap(5),
                FadeAnimation(
                  1.5,
                  InputField(
                    controller: _passwordController,
                    label: "Password".tr,
                    hint: "Enter your Password".tr,
                    type: "password",
                    onTap: () {
                      setState(
                        () {
                          _hidePassword = !_hidePassword;
                        },
                      );
                    },
                    icon: _hidePassword == true
                        ? "assets/icons/Eye.svg"
                        : "assets/icons/Invisible.svg",
                    obscureText: _hidePassword,
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => password = newValue,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your password".tr);
                      }
                      if (value!.length >= authController.passLength) {
                        removeError(error: "Password is too short".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your password".tr);
                      }
                      if (value.length < authController.passLength) {
                        addError(error: "Password is too short".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your password".tr);
                        return "";
                      } else if (value.length < authController.passLength) {
                        addError(error: "Password is too short".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(25),
                FadeAnimation(
                  1.6,
                  InputField(
                    controller: _confirmPasswordController,
                    label: "Confirm password".tr,
                    hint: "Re-enter your password".tr,
                    type: "password",
                    icon: "assets/icons/Lock.svg",
                    obscureText: _hidePassword,
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => confirm = newValue,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Re-Enter your password".tr);
                      }
                      if (value!.length >= authController.passLength) {
                        removeError(
                            error: "Confirmation Password is too short".tr);
                      }
                      if (_passwordController.value ==
                          _confirmPasswordController.value) {
                        removeError(error: "Password did not matched".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Re-Enter your password".tr);
                      }
                      if (value.length < 8) {
                        addError(
                            error: "Confirmation Password is too short".tr);
                      }
                      if (_passwordController.value !=
                          _confirmPasswordController.value) {
                        addError(error: "Password did not matched".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Re-Enter your password".tr);
                        return "";
                      } else if (value.length < authController.passLength) {
                        addError(
                            error: "Confirmation Password is too short".tr);
                        return "";
                      } else if (_passwordController.value !=
                          _confirmPasswordController.value) {
                        addError(error: "Password did not matched".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(10),
                FadeAnimation(
                  1.7,
                  FormError(errors: errors),
                ),
                const Gap(20),
                FadeAnimation(
                  1.8,
                  PrimaryButton(
                    text: "Register2".tr,
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _registerData['firstname'] = _firstnameController.text;
                        _registerData['lastname'] = _lastnameController.text;
                        _registerData['password'] = _passwordController.text;
                        _registerData['phone'] = _phoneController.text;
                        _registerData['app_version'] = app_version;
                        _registerData['lang'] = lang;
                        authController.register(registerData: _registerData);
                        //print(_registerData);
                      }
                    },
                  ),
                ),
                const Gap(20),
                FadeAnimation(
                  1.9,
                  BodyText(
                    text: "By continuing".tr,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
