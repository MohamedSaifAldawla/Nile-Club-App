import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nile_club/Controllers/auth_controller.dart';
import 'package:nile_club/Controllers/language_controller.dart';
import 'package:nile_club/Widgets/routes.dart';
import 'package:nile_club/localization.dart';
import 'package:nile_club/theme.dart';
import 'Controllers/local_auth_controller.dart';
import 'Controllers/profile_controller.dart';
import 'Globals/globals.dart';
import 'Services/api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  //------------- Init variable's ---------------//
  bool result = await InternetConnectionChecker().hasConnection;
  Api.initializeInterceptors();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await init();
  GetThemeMode();

  //------------- Firebase ---------------//
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    },
  );

  //------------- DeviceOrientation ---------------//
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //------------- Internet Connection ---------------//
  if (result == true) {
    print('Connected');
    runApp(MyApp());
  } else {
    await GetStorage().write("Live", null);
    print("isLive : $isLive");
    print('No internet :(');
    runApp(MyApp());
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  LocalAuthController local_auth = Get.put(LocalAuthController());
  LanguageController lang = Get.put(LanguageController());
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nile Club',
      locale: lang.language,
      fallbackLocale: const Locale('en'),
      translations: Localization(),
      themeMode: ThemeMode.light,
      theme: theme(fontFamily: ""),
      darkTheme: themeDark(fontFamily: ""),
      //home: SplashScreen(),
      getPages: routes,
    );
  }
}

void GetThemeMode() async {
  bool? isDark = await GetStorage().read("isDark");

  if (isDark == true) {
    Get.changeThemeMode(ThemeMode.dark);
  }
  if (isDark == false) {
    Get.changeThemeMode(ThemeMode.light);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}



// HttpOverrides.global = new MyHttpOverrides();
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           ((X509Certificate cert, String host, int port) {
//         final isValidHost =
//             ["nileclub.net"].contains(host); // <-- allow only hosts in array
//         return isValidHost;
//       });
//   }
// }

// void getHttp() async {
//   Dio dio = new Dio();
//   final response = await dio.get("https://nileclub.net");
//   print(response.data);
// }
