import 'package:get/get.dart';
import 'package:nile_club/Models/Memberships.dart';
import 'package:nile_club/Views/Profile/membership_list_screen.dart';

import '../Views/Home/all_news_screen.dart';
import '../Views/Home/home_screen.dart';
import '../Views/Home/transaction_screen.dart';
import '../Views/Profile/user_profile_screen.dart';
import '../Views/Settings_screen.dart';

class BarController extends GetxController {
  var currentIndex = 0.obs;
  var screens = [
    HomeScreen(),
    AllNewsScreen(),
    TransactionsScreen(),
    MembershipListScreen(),
    ProfileScreen(),
    //const SettingsScreen(),
  ];
}
