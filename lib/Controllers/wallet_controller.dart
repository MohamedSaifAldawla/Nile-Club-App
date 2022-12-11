import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/Models/user.dart';
import 'package:nile_club/Views/States/state_screen.dart';
import '../Services/api.dart';
import '../theme.dart';
import 'base_controller.dart';

class WalletController extends GetxController with BaseController {
  final clientID = 28;
  String url_app = '';
  String url_can = '';
  String url_dec = '';
  String checkOut = '';
  String? scannedQR;
  String clientName = '';
  String clientPhone = '';
  bool showDialog = false;
  bool successShowDialog = false;
  var moneyTransfer = {};
  final user = User().obs;

  //--------------------- Pay Gateway --------------------------//

  Future<void> PayGateway({required Map<String, dynamic> createData}) async {
    print(createData);
    showLoading();
    var response = await Api.PayGateway(uid: uid, amount: createData['amount']);
    checkOut = '';
    checkOut = response.data;
    hideLoading();
    Get.toNamed('checkout');

    //print(checkOut);
  } //end of Pay Gateway

  //--------------------- Wallet Balance --------------------------//

  Future<void> Balance() async {
    var response = await Api.Balance(uid: uid);
    final res = json.decode(response.data);
    if (res['statuscode'] == 3) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    } else {
      await GetStorage().write('balance', res['balance']);
      init();
      print("Balance : ${GetStorage().read("balance")}");
    }
  } //end of Wallet Balance

//--------------------- QR Scanner --------------------------//

  // Future<String> QRScanner() async {
  //   return scannedQR = await FlutterBarcodeScanner.scanBarcode(
  //       "#03A9F5", "Cancel".tr, true, ScanMode.QR);
  // } //end of QR Scanner

  //--------------------- Get Shop --------------------------//

  Future<void> GetShop() async {
    try {
      print("cl_accountId : $scannedQR");
      clientName = '';
      clientPhone = '';
      showLoading();
      var response = await Api.GetShop(cl_accountId: scannedQR);
      hideLoading();
      final res = json.decode(response.data);
      print("GetShop : $res");
      if (res['statuscode'] == 0) {
        clientName = res['message']['shop_name'];
        clientPhone = res['message']['phone'];
        successShowDialog = true;
      } else if (res['statuscode'] == 3) {
        SnackBar(
            "Error".tr,
            res['message'],
            SvgPicture.asset(
              "assets/icons/Close.svg",
              color: Colors.white,
            ),
            error,
            SnackPosition.TOP);
      }
    } catch (e) {
      SnackBar(
          "Error".tr,
          "$e",
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    }

    //print("GetShop : $clientName,$clientPhone");
  } //end of Get Shop

  //--------------------- Transfer Fund --------------------------//

  Future<void> TransferFund({required String amount}) async {
    showLoading();
    var response = await Api.TransferFund(
        amount: amount, cl_accountId: scannedQR!, transType: 't');
    hideLoading();
    final res = json.decode(response.data);
    print("TransferFund : $res");
    if (res['statuscode'] == 0) {
      await GetStorage().write('balance', res['balance'].toString());
      init();
      print("Balance : ${GetStorage().read('balance')}");
      moneyTransfer.clear();
      moneyTransfer.addAll(res);
      Get.offAllNamed('transferTicket');
    } else if (res['statuscode'] == 3) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    }
  } //end of Transfer Fund

  //--------------------- Approved Order --------------------------//

  ApprovedOrder() {
    Get.offAll(
      StateScreen(
        state: "success",
        text: "Order approved".tr,
        btntext: "homepage".tr,
      ),
    );
  } //end of Approved Order

  // //--------------------- Cancel Order --------------------------//

  CancelOrder() {
    Get.offAll(
      StateScreen(
        state: "error",
        text: "Order canceled".tr,
        btntext: "homepage".tr,
      ),
    );
  } //end of Cancel Order

  //--------------------- Decliend Order --------------------------//

  DecliendOrder() {
    Get.offAll(
      StateScreen(
        state: "error",
        text: "Order declined".tr,
        btntext: "homepage".tr,
      ),
    );
  } //end of Decliend Order

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
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
} //end of controller




//---------------------- Test Card ----------------------//
// Number => 9222081320072003333
// Expire => 06\26
// Pass => 1010
















// //--------------------- Create Order --------------------------//

//   Future<void> CreateOrder({required Map<String, dynamic> createData}) async {
//     UrlInit(createData);
//     print(createData);
//     showLoading();
//     var response = await Api.CreateOrder(createData: createData);
//     final res = json.decode(response.data);

//     //--------------------- Check Out --------------------------//
//     var response2 = await Api.CheckOut(
//         cln: clientID, orderID: res['order_id'], sessionID: res['session_id']);
//     checkOut = response2.data;
//     hideLoading();
//     Get.toNamed('checkout');

//     //print(checkOut);
//   } //end of Create Order



  // //--------------------- Url Init --------------------------//

  // UrlInit(createData) {
  //   createData['cln'] = clientID;
  //   createData['url_app'] =
  //       "https://app.nileclub.net/NileClubAPI/APIV4/approved?id=$userID&amt=" +
  //           createData['amount'];
  //   createData['url_can'] =
  //       "https://app.nileclub.net/NileClubAPI/APIV4/canceled?id=$userID&amt=" +
  //           createData['amount'];
  //   createData['url_dec'] =
  //       "https://app.nileclub.net/NileClubAPI/APIV4/declined?id=$userID&amt=" +
  //           createData['amount'];

  //   url_app = createData['url_app'];
  //   url_can = createData['url_can'];
  //   url_dec = createData['url_dec'];
  // } //end of Url Init