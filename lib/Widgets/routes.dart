import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nile_club/Services/login_middlleware.dart';
import 'package:nile_club/Services/middleware.dart';
import 'package:nile_club/Views/Home/connection_screen.dart';
import 'package:nile_club/Views/Home/maintenance_screen.dart';
import 'package:nile_club/Views/Home/trans_membership_screen.dart';
import 'package:nile_club/Views/Profile/activate.dart';
import 'package:nile_club/Views/Profile/money_transfer.dart';
import 'package:nile_club/Views/Profile/transfer_ticket_screen.dart';
import 'package:nile_club/Views/Services/offers_screen.dart';
import 'package:nile_club/Views/Profile/membership_confirm_screen.dart';
import 'package:nile_club/Views/Profile/check_out.dart';
import 'package:nile_club/Views/Profile/contact_screen.dart';
import 'package:nile_club/Views/Profile/edit_account.dart';
import 'package:nile_club/Views/Profile/family_screen.dart';
import 'package:nile_club/Views/Profile/membership_list_screen.dart';
import '../Views/Auth/intro_screen.dart';
import '../Views/Auth/login_screen.dart';
import '../Views/Auth/otp_screen.dart';
import '../Views/Auth/redeem_account_screen.dart';
import '../Views/Auth/register_screen.dart';
import '../Views/Auth/resetpass_screen.dart';
import '../Views/Auth/splash_screen.dart.dart';
import '../Views/Profile/finger_auth.dart';
import '../Views/Services/cinema_screen.dart';
import '../Views/Home/all_news_screen.dart';
import '../Views/Home/home_page.dart';
import '../Views/Services/events_screen.dart';
import '../Views/Home/home_screen.dart';
import '../Views/Services/service_ticket_info.dart';
import '../Views/Home/transaction_screen.dart';
import '../Views/Profile/charge_wallet.dart';
import '../Views/Profile/membership_screen.dart';
import '../Views/Profile/user_profile_screen.dart';
import '../Views/Services/services_screen.dart';
import '../Views/Settings_screen.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: "/", page: () => SplashScreen()),
  GetPage(
    name: '/intro',
    page: () => const IntroScreen(),
    middlewares: [MiddleWare()],
  ),
  GetPage(
    name: "/login",
    page: () => const LoginScreen(),
    middlewares: [LoginMiddleWare()],
  ),
  GetPage(name: "/register", page: () => const RegisterScreen()),
  GetPage(name: "/reset", page: () => const ResetPasswordScreen()),
  GetPage(name: "/redeem", page: () => const RedeemAccountScreen()),
  GetPage(name: "/otp", page: () => OTPScreen()),
  GetPage(name: "/auth", page: () => const FingerAuthScreen()),
  GetPage(name: "/homepage", page: () => HomePage()),
  GetPage(name: "/home", page: () => HomeScreen()),
  GetPage(name: "/services", page: () => ServicesScreen()),
  GetPage(name: "/news", page: () => AllNewsScreen()),
  GetPage(name: "/cinema", page: () => CinemaScreen()),
  GetPage(name: "/offers", page: () => OffersScreen()),
  GetPage(
    name: "/transactions",
    page: () => TransactionsScreen(),
  ),
  GetPage(name: "/ticketinfo", page: () => ServiceTicketInfo()),
  GetPage(name: "/events", page: () => const EventsScreen()),
  GetPage(name: "/profile", page: () => ProfileScreen()),
  GetPage(name: "/account", page: () => EditAccount()),
  GetPage(name: "/wallet", page: () => ChargeWallet()),
  GetPage(name: "/transfer", page: () => MoneyTransferScreen()),
  GetPage(name: "/transferTicket", page: () => TransferTicketScreen()),
  GetPage(name: "/activate", page: () => Activate()),
  GetPage(name: "/checkout", page: () => WalletCheckOut()),
  GetPage(name: "/membershiplist", page: () => MembershipListScreen()),
  GetPage(name: "/membership", page: () => MembershipScreen()),
  GetPage(name: "/transmembership", page: () => TransMembershipScreen()),
  GetPage(name: "/membershipconfirm", page: () => MembershipConfirmScreen()),
  GetPage(name: "/family", page: () => FamilyScreen()),
  GetPage(name: "/contact", page: () => const ContactScreen()),
  GetPage(name: "/maintenance", page: () => const MaintenanceScreen()),
  GetPage(name: "/connection", page: () => const ConnectionScreen()),
  GetPage(name: "/settings", page: () => const SettingsScreen()),
];

// Map<String, Widget Function(BuildContext)> routes = {
//   "intro": (context) => const IntroScreen(),
//   "splash": (context) => SplashScreen(),
//   "login": (context) => LoginScreen(),
// };
