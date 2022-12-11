import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/Widgets/secondery_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../Controllers/wallet_controller.dart';
import '../../theme.dart';

class MembershipQR extends StatefulWidget {
  MembershipQR({Key? key, required this.serial}) : super(key: key);
  final String serial;
  @override
  State<StatefulWidget> createState() => _MembershipQRState();
}

class _MembershipQRState extends State<MembershipQR> {
  WalletController walletController = Get.find<WalletController>();
  final formKey = GlobalKey<FormState>();
  Barcode? barcode;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: kPrimaryLightColor),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Expanded(
            child: _buildQrView(context),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: SeconderyButton3(
              text: "Resume Scanning".tr,
              color: kPrimaryLightColor,
              press: () async {
                await controller?.resumeCamera();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: kPrimaryColor,
        borderLength: 20,
        borderWidth: 10,
        borderRadius: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(
      () {
        this.controller = controller;
        controller.resumeCamera();
        //reassemble();
      },
    );
    controller.scannedDataStream.listen(
      (scanData) {
        barcode = scanData;
        profileController.scannedQR = barcode!.code;
        controller.pauseCamera();
        print(profileController.scannedQR);
        profileController.Activate(
            serial: widget.serial, accountID: profileController.scannedQR);
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
