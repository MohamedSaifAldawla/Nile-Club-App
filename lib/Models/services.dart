class ServiceList {
  final List<Services> services;

  ServiceList({required this.services});

  factory ServiceList.fromJson(Map<String, dynamic> json) {
    return ServiceList(
      services: parseService(json),
    );
  }

  static List<Services> parseService(json) {
    var list = json['servicesList'] as List;
    List<Services> serviceList =
        list.map((data) => Services.fromJson(data)).toList();
    return serviceList;
  }
}

class Services {
  Services({
    this.id,
    this.eventId,
    this.ticketType,
    this.note,
    this.price,
    this.img,
    this.expired,
    this.enteranceNo,
    this.flagEnterance,
    this.areas,
    this.fees,
    this.tax,
    this.extraTax,
    this.totalPrice,
    this.totalQty,
    this.availableQty,
    this.online,
    this.status,
    this.outputNoFamily,
    this.discountPrice,
  });

  String? id;
  String? eventId;
  String? ticketType;
  String? note;
  String? price;
  String? img;
  String? expired;
  String? enteranceNo;
  String? flagEnterance;
  String? areas;
  String? fees;
  String? tax;
  String? extraTax;
  String? totalPrice;
  String? totalQty;
  String? availableQty;
  String? online;
  String? status;
  String? outputNoFamily;
  String? discountPrice;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        id: json["id"],
        eventId: json["event_id"],
        ticketType: json["ticket_type"],
        note: json["note"],
        price: json["price"],
        img: json["img"],
        expired: json["expired"],
        enteranceNo: json["enteranceNo"],
        flagEnterance: json["flag_enterance"],
        areas: json["areas"],
        fees: json["fees"],
        tax: json["tax"],
        extraTax: json["extra_tax"],
        totalPrice: json["total_price"],
        totalQty: json["total_qty"],
        availableQty: json["available_qty"],
        online: json["online"],
        status: json["status"],
        discountPrice: json["discount_price"],
      );
}















// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

//import 'dart:convert';

// Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

// class Service {
//   Service({
//     this.servicesList,
//   });

//   List<ServicesList>? servicesList;

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//         servicesList: List<ServicesList>.from(
//             json["servicesList"].map((x) => ServicesList.fromJson(x))),
//       );
// }

  
// class ServicesList {
//   ServicesList({
//     this.id,
//     this.eventId,
//     this.ticketType,
//     this.note,
//     this.price,
//     this.img,
//     this.expired,
//     this.enteranceNo,
//     this.flagEnterance,
//     this.areas,
//     this.fees,
//     this.tax,
//     this.extraTax,
//     this.totalPrice,
//     this.totalQty,
//     this.availableQty,
//     this.online,
//     this.status,
//   });

//   String? id;
//   String? eventId;
//   String? ticketType;
//   String? note;
//   String? price;
//   String? img;
//   String? expired;
//   String? enteranceNo;
//   String? flagEnterance;
//   String? areas;
//   String? fees;
//   String? tax;
//   String? extraTax;
//   String? totalPrice;
//   String? totalQty;
//   String? availableQty;
//   String? online;
//   String? status;

//   factory ServicesList.fromJson(Map<String, dynamic> json) => ServicesList(
//         id: json["id"],
//         eventId: json["event_id"],
//         ticketType: json["ticket_type"],
//         note: json["note"],
//         price: json["price"],
//         img: json["img"],
//         expired: json["expired"],
//         enteranceNo: json["enteranceNo"],
//         flagEnterance: json["flag_enterance"],
//         areas: json["areas"],
//         fees: json["fees"],
//         tax: json["tax"],
//         extraTax: json["extra_tax"],
//         totalPrice: json["total_price"],
//         totalQty: json["total_qty"],
//         availableQty: json["available_qty"],
//         online: json["online"],
//         status: json["status"],
//       );
// }
