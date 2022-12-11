import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nile_club/Controllers/wallet_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Globals/globals.dart';

class WalletCheckOut extends StatefulWidget {
  const WalletCheckOut({Key? key}) : super(key: key);

  @override
  State<WalletCheckOut> createState() => _WalletCheckOutState();
}

class _WalletCheckOutState extends State<WalletCheckOut> {
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Check Out"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: Uri.dataFromString(walletController.checkOut,
                mimeType: 'text/html', encoding: utf8)
            .toString(),
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (_) {
          readResponse();
        },
      ),
    );
  }

  void readResponse() {
    _controller
        .runJavascriptReturningResult("document.documentElement.innerHTML")
        .then(
      (value) async {
        if (value.contains("Payment successful")) {
          walletController.Balance();
          final res = json.decode(value);
          var html = res;
          var parsed = Bidi.stripHtmlIfNeeded(html);
          final jsonRes = jsonDecode(parsed);
          walletController.moneyTransfer.clear();
          walletController.moneyTransfer.addAll(jsonRes);
          print(walletController.moneyTransfer);
          print("approved");
          Get.offAllNamed('transferTicket');
          //walletController.ApprovedOrder();
        } else if (value.contains("Payment Canceled")) {
          print("Canceled");
          walletController.CancelOrder();
        } else if (value.contains("Payment Declined")) {
          print("Declined");
          walletController.DecliendOrder();
        }
      },
    );
  }
}
