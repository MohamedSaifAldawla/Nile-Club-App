import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: library_prefixes
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';
import '../Globals/globals.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://app.nileclub.net/NileClubAPI/APIV4',
      receiveDataWhenStatusError: true,
    ),
  );

  //--------------------- initializeInterceptors --------------------------//
  static void initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          var headers = {
            'accept': 'application/json',
            'content-Type': 'application/x-www-form-urlencoded',
            //'Authorization': 'Bearer ${token}',
          };
          request.headers.addAll(headers);
          print('${request.method} ${request.path}');
          print('${request.headers}');
          return handler.next(request); //continue
        },
        onResponse: (response, handler) {
          //debugPrint(response.data);
          //   final Map res = json.decode(response.data);
          //   print(res);

          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          if (GET.Get.isDialogOpen == true) {
            GET.Get.back();
          }
          if (e.error is SocketException) {
            GET.Get.snackbar(
              'Erorr',
              'Connection lost'.tr,
              //'${e.error.message}',
              icon: SvgPicture.asset(
                "assets/icons/Close.svg",
                color: Colors.white,
              ),
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              borderRadius: 20,
              duration: Duration(seconds: 5),
              snackPosition: GET.SnackPosition.TOP,
              backgroundColor: Color(0xFFE84C5C),
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack,
            );
          } else if (e.error is HttpException) {
            GET.Get.snackbar(
              'Erorr',
              'Bad Connection'.tr,
              //'${e.error.message}',
              icon: SvgPicture.asset(
                "assets/icons/Close.svg",
                color: Colors.white,
              ),
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              borderRadius: 20,
              duration: Duration(seconds: 5),
              snackPosition: GET.SnackPosition.TOP,
              backgroundColor: Color(0xFFE84C5C),
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack,
            );
          } else if (e.type == DioErrorType.connectTimeout) {
            GET.Get.snackbar(
              'Erorr',
              'Connection time out'.tr,
              //'${e.error.message}',
              icon: SvgPicture.asset(
                "assets/icons/Close.svg",
                color: Colors.white,
              ),
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              borderRadius: 20,
              duration: Duration(seconds: 5),
              snackPosition: GET.SnackPosition.TOP,
              backgroundColor: Color(0xFFE84C5C),
              colorText: Colors.white,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack,
            );
          }

          throw e.error;
        },
      ),
    );
  } // end of initializeInterceptor

//--------------------- User Operations --------------------------//
//--------------------- Login --------------------------//

  static Future<Response> login({loginData}) async {
    FormData formData = FormData.fromMap(loginData);
    return dio.post('/login', data: formData);
  } //end of login

//--------------------- Register --------------------------//

  static Future<Response> register({registerData}) async {
    FormData formData = FormData.fromMap(registerData);
    return dio.post('/registeraton', data: formData);
  } //end of register

  //--------------------- Account Update --------------------------//

  static Future<Response> AccountUpdate({
    required String name,
    required String password,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'name': name,
        'password': password,
        'app_version': app_version,
      },
    );
    return dio.post('/updateProfile', data: formData);
  } //end of Account Update

  //--------------------- Delete Account --------------------------//

  static Future<Response> DeleteAccount() async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
      },
    );
    return dio.post('/deleteAccount', data: formData);
  } //end of Delete Account

  //--------------------- Subscribe --------------------------//

  static Future<Response> Subscribe({subscribeData}) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
        'name': subscribeData['name'],
        'type': subscribeData['type'],
        'address': subscribeData['address'],
        'dofb': subscribeData['dofb'],
        'gender': subscribeData['gender'],
        'months': subscribeData['months'],
        'membership_status': subscribeData['membership_status'],
        'membership_id': subscribeData['membership_id'],
        'email': subscribeData['email'],
        'phone': subscribeData['phone'],
        'occup': subscribeData['occup'],
        'ticket_id': subscribeData['ticket_id'],
        'img': subscribeData['img'],
        'pid': subscribeData['pid'],
        'img64': subscribeData['img64'],
        'pid64': subscribeData['pid64'],
      },
    );
    print("personalId :" + subscribeData['pid64']);
    return dio.post('/subscribe', data: formData);
  } //end of Subscribe

  //--------------------- Add Family --------------------------//

  static Future<Response> AddFamily({familyData}) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
        'formid': GetStorage().read('formid'),
        'type': familyData['type'],
        'name': familyData['name'],
        'dofb': familyData['dofb'],
        'gender': familyData['gender'],
        'phone': familyData['phone'],
        'img': familyData['img'],
        'pid': familyData['pid'],
        'img64': familyData['img64'],
        'pid64': familyData['pid64'],
      },
    );
    return dio.post('/addFamily', data: formData);
  } //end of Add Family

  //--------------------- Reset Password --------------------------//

  static Future<Response> ResetPassword({
    required String phone,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'phone': phone,
        'app_version': app_version,
      },
    );
    return dio.post('/resetPassword', data: formData);
  } //end of Reset Password

//--------------------- Get Users --------------------------//

  static Future<Response> getUsers() async {
    return dio.get('/allUsers');
  } //end of getUsers

  //--------------------- Valid Token --------------------------//

  static Future<Response> ValidToken({
    required String uid,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
      },
    );
    return dio.post('/checkToken', data: formData);
  } //end of Valid Token

  static Future<Response> Activate({
    required String? serial,
    required String? accountID,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'account_id': accountID,
        'serial': serial,
        'app_version': app_version,
      },
    );
    return dio.post('/activate', data: formData);
  } //end of Activate

//--------------------- Services Operations --------------------------//
  //--------------------- Services --------------------------//

  static Future<Response> Services({
    required String catId,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'app_version': app_version,
        'cat_id': catId,
      },
    );
    return dio.post('/loadServicesList', data: formData);
  } //end of Services

  static Future<Response> EventsAndCinema({
    required String catId,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'app_version': app_version,
        'cat_id': catId,
      },
    );
    return dio.post('/loadEventList', data: formData);
  } //end of Services

  //--------------------- Service booking --------------------------//

  static Future<Response> Servicebooking({
    required String ticketId,
    required String ticketQuantity,
    required String eventId,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
        'tt_id': ticketId,
        'tk_qty': ticketQuantity,
        'event_id': eventId
      },
    );
    return dio.post('/serviceReserve', data: formData);
  } //end of Service booking

  //--------------------- Event booking --------------------------//

  static Future<Response> Eventbooking({
    required String eventId,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'app_version': app_version,
        'event_id': eventId,
      },
    );
    return dio.post('/loadTicketTypeList', data: formData);
  } //end of Event booking

  //---------------------  Memberships --------------------------//

  static Future<Response> GetMembershipsList() async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'app_version': app_version,
      },
    );
    return dio.post('/loadMembershipList', data: formData);
  } //end of Services

  static Future<Response> GetMemberships() async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
      },
    );
    return dio.post('/getMemberships', data: formData);
  } //end of Get Memberships

  //--------------------- Get History --------------------------//

  static Future<Response> GetHistory({
    required String uid,
    required String token,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
      },
    );
    return dio.post('/getHistory', data: formData);
  } //end of Get History

//--------------------- Wallet Operations --------------------------//
  //--------------------- Create Order --------------------------//

  static Future<Response> CreateOrder({createData}) async {
    FormData formData = FormData.fromMap(createData);
    return dio.post('https://quickpay.sd/cpayment/exec/corder', data: formData);
  } //end of Create Order

  //--------------------- Pay Gateway --------------------------//

  static Future<Response> PayGateway({
    required String uid,
    required String amount,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'amt': amount,
        'token': token,
        'app_version': app_version
      },
    );
    return dio.post('/PayGetway', data: formData);
  } //end of Pay Gateway

  //--------------------- Check Out --------------------------//

  static Future<Response> CheckOut({
    int? cln,
    String? orderID,
    String? sessionID,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'cln': cln,
        'order_id': orderID,
        'session_id': sessionID,
      },
    );
    return dio.post('https://quickpay.sd/cpayment/exec/chechout',
        data: formData);
  } //end of Check Out

  //--------------------- Wallet Balance --------------------------//

  static Future<Response> Balance({
    String? uid,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
      },
    );
    return dio.post('/getWalletBalance', data: formData);
  } //end of Wallet Balance

  static Future<Response> GetShop({
    required String? cl_accountId,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'app_version': app_version,
        'account_id': cl_accountId,
      },
    );
    return dio.post('/getShop', data: formData);
  } //end of Get Shop

  static Future<Response> TransferFund({
    required String cl_accountId,
    required String transType,
    required String amount,
  }) async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'userid': uid,
        'token': token,
        'amount': amount,
        'app_version': app_version,
        'trans_type': transType,
        'receiver_id': cl_accountId,
      },
    );
    return dio.post('/transferFund', data: formData);
  } //end of Transfer Fund
  //--------------------- Blogs Operations --------------------------//
  //--------------------- Blogs --------------------------//

  static Future<Response> Blogs() async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'app_version': app_version,
      },
    );
    return dio.post('/loadBlogs', data: formData);
  } //end of Blogs

  //--------------------- App Level Api --------------------------//
  //--------------------- App Live --------------------------//

  static Future<Response> AppLive() async {
    FormData formData = FormData.fromMap(
      {
        'lang': lang,
        'app_version': app_version,
      },
    );
    return dio.post('/appLive', data: formData);
  } //end of Blogs

} //end of api
