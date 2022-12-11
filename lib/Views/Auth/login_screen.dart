import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Controllers/auth_controller.dart';
import 'package:nile_club/Widgets/primary_button.dart';
import 'package:nile_club/theme.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Globals/globals.dart';
import '../../Widgets/WaveClipper.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/no_account_text.dart';
import '../../Widgets/secondery_button.dart';
import '../../size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? phone;
  String? password;
  double app_version = 1.4;

  bool _hidePassword = true;
  bool remember = false;
  final List<String> errors = [];
  final Map<String, dynamic> _loginData = {};

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
    loadUserEmailPassword();
    Future.delayed(Duration(seconds: 1), () async {
      Login();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "Login".tr,
        //   style: TextStyle(color: kPrimaryLightColor),
        // ),
        backgroundColor: kPrimaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Stack(
            children: [
              waveClipper2(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(horizontalPadding),
                    vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Image.asset(
                      //   "assets/images/Splash.png",
                      //   height: getProportionateScreenHeight(100),
                      //   width: getProportionateScreenWidth(100),
                      // ),
                      const Gap(70),
                      FadeAnimation(
                        1.2,
                        ScreenTitle(text: "Welcome".tr),
                      ),
                      const Gap(10),
                      FadeAnimation(
                        1.5,
                        BodyText(text: "Login with your Username".tr),
                      ),
                      const Gap(40),
                      FadeAnimation(
                        1.6,
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
                              removeError(
                                  error: "Phone number is too short".tr);
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
                      // const Gap(10),
                      FadeAnimation(
                        1.7,
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
                              removeError(
                                  error: "Please Enter your password".tr);
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
                            } else if (value.length <
                                authController.passLength) {
                              addError(error: "Password is too short".tr);
                              return "";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Gap(10),
                      FadeAnimation(
                        1.8,
                        Row(
                          children: [
                            Checkbox(
                              value: remember,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                setState(
                                  () {
                                    remember = value!;
                                    if (remember == true) {
                                      GetStorage().write('remember', remember);
                                      GetStorage().write(
                                          'phone', _phoneController.text);
                                      GetStorage().write(
                                          'password', _passwordController.text);

                                      print(remember);
                                      print(GetStorage().read("phone"));
                                      print(GetStorage().read("password"));
                                    } else if (remember == false) {
                                      GetStorage().remove("phone");
                                      GetStorage().remove("password");
                                      GetStorage().remove("remember");
                                      print(remember);
                                    }
                                  },
                                );
                              },
                            ),
                            BodyText(
                              text: "Remember me".tr,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("reset");
                              },
                              child: BodyText(
                                text: "Forgot Password".tr,
                                color: kPrimaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Gap(10),
                      FadeAnimation(
                        1.9,
                        FormError(errors: errors),
                      ),
                      const Gap(20),
                      FadeAnimation(
                        2,
                        PrimaryButton(
                          text: "Login".tr,
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _loginData['phone'] = _phoneController.text;
                              _loginData['password'] = _passwordController.text;
                              //_loginData['phone'] = '0907942294';
                              _loginData['app_version'] = app_version;
                              _loginData['lang'] = lang;
                              authController.login(loginData: _loginData);
                              if (remember == true) {
                                GetStorage().write('remember', remember);
                                GetStorage()
                                    .write('phone', _phoneController.text);
                                GetStorage().write(
                                    'password', _passwordController.text);

                                print(remember);
                                print(GetStorage().read("phone"));
                                print(GetStorage().read("password"));
                              }
                              //Get.toNamed("welcome");
                            }
                          },
                        ),
                      ),
                      const Gap(20),
                      FadeAnimation(
                        2.1,
                        SeconderyButton(
                          text: "Register".tr,
                          press: () {
                            Get.toNamed("register");
                          },
                        ),
                      ),
                      // const Gap(20),
                      // FadeAnimation(
                      //   2.2,
                      //   BodyText(text: "---- OR ----".tr),
                      // ),
                      // const Gap(10),
                      // FadeAnimation(
                      //   2.3,
                      //   NoAccountText(
                      //     text1: "Login as a ".tr,
                      //     text2: "Visitor".tr,
                      //   ),
                      // ),
                      const Gap(15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    if (await GetStorage().read('login_token') == null &&
        local_auth.autoLogin == true &&
        remember == true) {
      print(GetStorage().read('login_token'));
      _loginData['phone'] = _phoneController.text;
      _loginData['password'] = _passwordController.text;
      _loginData['app_version'] = app_version;
      authController.login(loginData: _loginData);

      if (remember == true) {
        GetStorage().write('remember', remember);
        GetStorage().write('phone', _phoneController.text);
        GetStorage().write('password', _passwordController.text);

        print(remember);
        print(GetStorage().read("phone"));
        print(GetStorage().read("password"));
      }
    }
  }

  void loadUserEmailPassword() async {
    try {
      if (await GetStorage().read("remember")) {
        print(GetStorage().read("remember"));
        _phoneController.text = await GetStorage().read("phone");
        _passwordController.text = await GetStorage().read("password");
        setState(() {
          remember = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
