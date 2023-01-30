import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Controllers/auth_controller.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../theme.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? username;
  String? password;
  String? confirm;
  bool _hidePassword = true;

  final List<String> errors = [];
  Map<String, dynamic> _updateData = {};

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
  void initState() {
    // TODO: implement initState
    _usernameController.text = GetStorage().read('name');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Account".tr)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 30),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ScreenTitle(text: "Account Details".tr),
                  const Gap(5),
                  BodyText(
                    text: "Update your account information".tr,
                    maxLines: 2,
                  ),
                  const Gap(30),
                  InputField(
                    controller: _usernameController,
                    label: "Username".tr,
                    hint: "Enter your Username".tr,
                    type: "Username",
                    icon: "assets/icons/User.svg",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => username = newValue,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your Username".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Username".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Username".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                  const Gap(25),
                  InputField(
                    controller: _passwordController,
                    label: "New Password".tr,
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
                  ),
                  const Gap(25),
                  InputField(
                    controller: _confirmPasswordController,
                    label: "Confirm New password".tr,
                    hint: "Re-enter your password".tr,
                    type: "password",
                    icon: "assets/icons/Lock.svg",
                    obscureText: _hidePassword,
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) => confirm = newValue,
                  ),
                  const Gap(10),
                  FormError(errors: errors),
                  const Gap(20),
                  PrimaryButton(
                    text: "confirm Upadte".tr,
                    press: () {
                      if (_passwordController.text.isNotEmpty) {
                        if (_passwordController.text.length <
                            authController.passLength) {
                          addError(error: "Password is too short".tr);
                        }
                        if (_passwordController.text.length >=
                            authController.passLength) {
                          removeError(error: "Password is too short".tr);
                        }

                        if (_confirmPasswordController.text.isEmpty) {
                          addError(error: "Please Re-Enter your password".tr);
                        }
                        if (_confirmPasswordController.text.isNotEmpty) {
                          removeError(
                              error: "Please Re-Enter your password".tr);
                        }

                        if (_confirmPasswordController.text.length <
                            authController.passLength) {
                          addError(
                              error: "Confirmation Password is too short".tr);
                        }
                        if (_confirmPasswordController.text.length >=
                            authController.passLength) {
                          removeError(
                              error: "Confirmation Password is too short".tr);
                        }

                        if (_passwordController.value !=
                            _confirmPasswordController.value) {
                          addError(error: "Password did not matched".tr);
                        }
                        if (_passwordController.value ==
                            _confirmPasswordController.value) {
                          removeError(error: "Password did not matched".tr);
                        }
                      }
                      if (_passwordController.text.isNotEmpty &&
                          _confirmPasswordController.text.isNotEmpty &&
                          _passwordController.text.length >=
                              authController.passLength &&
                          _confirmPasswordController.text.length >=
                              authController.passLength &&
                          _passwordController.value ==
                              _confirmPasswordController.value) {
                        _updateData['name'] = _usernameController.text;
                        _updateData['password'] = _passwordController.text;
                        authController.AccountUpdate(updateData: _updateData);
                      } else if (_passwordController.text.isEmpty) {
                        _updateData['name'] = _usernameController.text;
                        // _updateData['password'] = _passwordController.text;
                        authController.AccountUpdate(updateData: _updateData);
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
}




 // if (_formKey.currentState!.validate()) {
                      //   _updateData['name'] = _usernameController.text;
                      //   _updateData['password'] = _passwordController.text;
                      //   authController.AccountUpdate(updateData: _updateData);
                      // }




                    // onChanged: (value) {
                    //   if (value == null || value.isNotEmpty) {
                    //     removeError(error: "Please Enter your password".tr);
                    //   }
                    //   if (value!.length >= authController.passLength) {
                    //     removeError(error: "Password is too short".tr);
                    //   }
                    //   if (value == null || value.isEmpty) {
                    //     addError(error: "Please Enter your password".tr);
                    //   }
                    //   if (value.length < authController.passLength) {
                    //     addError(error: "Password is too short".tr);
                    //   }
                    // },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     addError(error: "Please Enter your password".tr);
                    //     return "";
                    //   } else if (value.length < authController.passLength) {
                    //     addError(error: "Password is too short".tr);
                    //     return "";
                    //   }
                    //   return null;
                    // },
 // onChanged: (value) {
                    //   if (value == null || value.isNotEmpty) {
                    //     removeError(error: "Please Re-Enter your password".tr);
                    //   }
                    //   if (value!.length >= authController.passLength) {
                    //     removeError(
                    //         error: "Confirmation Password is too short".tr);
                    //   }
                    //   if (_passwordController.value ==
                    //       _confirmPasswordController.value) {
                    //     removeError(error: "Password did not matched".tr);
                    //   }
                    //   if (value == null || value.isEmpty) {
                    //     addError(error: "Please Re-Enter your password".tr);
                    //   }
                    //   if (value.length < 8) {
                    //     addError(
                    //         error: "Confirmation Password is too short".tr);
                    //   }
                    //   if (_passwordController.value !=
                    //       _confirmPasswordController.value) {
                    //     addError(error: "Password did not matched".tr);
                    //   }
                    // },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     addError(error: "Please Re-Enter your password".tr);
                    //     return "";
                    //   } else if (value.length < authController.passLength) {
                    //     addError(
                    //         error: "Confirmation Password is too short".tr);
                    //     return "";
                    //   } else if (_passwordController.value !=
                    //       _confirmPasswordController.value) {
                    //     addError(error: "Password did not matched".tr);
                    //     return "";
                    //   }
                    //   return null;
                    // },