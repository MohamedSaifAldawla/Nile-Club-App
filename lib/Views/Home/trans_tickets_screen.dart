import 'package:flutter/material.dart';
import 'package:nile_club/Models/transactions.dart';
import '../../Widgets/ticket_card.dart';

class TransTicketsScreen extends StatelessWidget {
  const TransTicketsScreen({Key? key, required this.transaction})
      : super(key: key);
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Ticket Details"),
      ),
      body: TicketCard(transaction, context),
    );
  }
}
