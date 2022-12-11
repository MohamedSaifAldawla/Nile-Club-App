import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nile_club/Models/transactions.dart';
import 'package:nile_club/Widgets/membership_card.dart';
import '../../Widgets/ticket_card.dart';

class MembershipConfirmScreen extends StatelessWidget {
  const MembershipConfirmScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Membership Confirmation".tr),
      ),
      body: MembershipCard(context),
    );
  }
}
