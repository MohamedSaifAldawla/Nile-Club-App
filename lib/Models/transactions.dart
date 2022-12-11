class TransList {
  final List<Transaction> trans;

  TransList({required this.trans});

  factory TransList.fromJson(Map<String, dynamic> json) {
    return TransList(
      trans: parseService(json),
    );
  }

  static List<Transaction> parseService(json) {
    var list = json['historyList'] as List;
    List<Transaction> transList =
        list.map((data) => Transaction.fromJson(data)).toList();
    return transList;
  }
}

class Transaction {
  String? id;
  String? type;
  String? alias;
  String? aliasAr;
  String? data;
  String? qty;
  String? status;
  String? amount;
  String? phone;
  String? response;
  String? responsemessage;
  String? date;
  String? transKey;
  String? output;
  String? outputDate;
  String? outputType;
  String? outputPhone;
  String? outputResponsemessage;
  String? outputStatus;
  String? outputAmount;
  String? outputQty;
  String? outputBalance;
  String? outputOrganizer;
  String? outputTicketType;
  String? serials;
  String? outputNoFamily;
  String? outputExtraFees;
  String? outputImg;
  String? outputNote;

  Transaction({
    this.id,
    this.type,
    this.alias,
    this.aliasAr,
    this.data,
    this.qty,
    this.status,
    this.amount,
    this.phone,
    this.response,
    this.responsemessage,
    this.date,
    this.transKey,
    this.output,
    this.outputDate,
    this.outputType,
    this.outputPhone,
    this.outputResponsemessage,
    this.outputStatus,
    this.outputAmount,
    this.outputQty,
    this.outputBalance,
    this.outputOrganizer,
    this.outputTicketType,
    this.serials,
    this.outputNoFamily,
    this.outputExtraFees,
    this.outputImg,
    this.outputNote,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    alias = json['alias'];
    aliasAr = json['alias_ar'];
    data = json['data'];
    qty = json['qty'];
    status = json['status'];
    amount = json['amount'];
    phone = json['phone'];
    response = json['response'];
    responsemessage = json['responsemessage'];
    date = json['date'];
    transKey = json['transKey'];
    output = json['output'];
    outputDate = json['output_date'];
    outputType = json['output_type'];
    outputPhone = json['output_phone'];
    outputResponsemessage = json['output_responsemessage'];
    outputStatus = json['output_status'];
    outputAmount = json['output_amount'];
    outputQty = json['output_qty'];
    outputBalance = json['output_balance'].toString();
    outputOrganizer = json['output_organizer'];
    outputTicketType = json['output_ticket_Type'];
    serials = json['serials'];
    outputNoFamily = json["output_no_family"];
    outputExtraFees = json["output_extraFees"].toString();
    outputImg = json["output_img"].toString();
    outputNote = json["output_note"].toString();
  }
}
