import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Controllers/trans_controller.dart';
import 'package:nile_club/Models/services.dart';
import '../Globals/globals.dart';
import '../Models/eventsCinema.dart';
import '../Models/eventsTickets.dart';
import '../Services/api.dart';
import '../Views/Services/single_event_screen.dart';
import '../theme.dart';
import 'base_controller.dart';

class ServicesController extends GetxController with BaseController {
  final transController = Get.find<TransController>();

  var serviceReserve = {};
  List<Services> services = <Services>[].obs;
  List<Services> offers = <Services>[].obs;
  List<EventsCinema> eventsCinema = <EventsCinema>[].obs;
  List<EventsTickets> eventsTickets = <EventsTickets>[].obs;
  RxInt counter = 0.obs;
  RxInt total = 0.obs;
  String? screenTitle;

  @override
  void onInit() async {
    // if (await GetStorage().read('login_token') != null) {
    //   await getHomeOffers();
    // }
    counter.value = 0;
    total.value = 0;
    super.onInit();
  }

//--------------------- Get Services --------------------------//

  Future<void> getServices() async {
    showLoading();
    var response = await Api.Services(catId: "1");
    hideLoading();
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
    }
    if (res['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      authController.logout();
    } else {
      ServiceList servicereponse = ServiceList.fromJson(res);
      services.clear();
      services.addAll(servicereponse.services);
      print(services);
      Get.toNamed("services");
    }
  }

  //--------------------- Get Offers --------------------------//

  Future<void> getOffers() async {
    showLoading();
    var response = await Api.Services(catId: "5");
    hideLoading();
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
    }
    if (res['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      authController.logout();
    } else {
      ServiceList offersreponse = ServiceList.fromJson(res);
      offers.clear();
      offers.addAll(offersreponse.services);
      print("Offers : $offers");
      Get.toNamed("offers");
    }
  }

  //--------------------- Get Home Offers --------------------------//

  Future<void> getHomeOffers() async {
    //showLoading();

    var response = await Api.Services(catId: "5");
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
    }
    if (res['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      authController.logout();
    } else {
      ServiceList offersreponse = ServiceList.fromJson(res);
      offers.clear();
      offers.addAll(offersreponse.services);
      print("Offers : $offers");
    }
    //hideLoading();
    //Get.toNamed("offers");
  }

  //--------------------- Get Cinema --------------------------//

  Future<void> getCinema() async {
    showLoading();
    var response = await Api.EventsAndCinema(catId: "4");
    hideLoading();
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
    }
    if (res['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      authController.logout();
    } else {
      EventCinemaList cinemareponse = EventCinemaList.fromJson(res);
      eventsCinema.clear();
      eventsCinema.addAll(cinemareponse.eventsCinema);
      print("Cinema : $eventsCinema");
      screenTitle = "Cinema";
      Get.toNamed("events");
    }
  }
  //--------------------- Get getEvents --------------------------//

  Future<void> getEvents() async {
    showLoading();
    var response = await Api.EventsAndCinema(catId: "6");
    hideLoading();
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
    }
    if (res['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      authController.logout();
    } else {
      EventCinemaList eventsreponse = EventCinemaList.fromJson(res);
      eventsCinema.clear();
      eventsCinema.addAll(eventsreponse.eventsCinema);
      print("Events : $eventsCinema");
      screenTitle = "Events";
      Get.toNamed("events");
    }
  } //end of Get getEvents

  //--------------------- Service booking --------------------------//

  Future<void> Servicebooking(
      {required Map<String, dynamic> servicedata}) async {
    // print("Reserved Service : $servicedata");

    showLoading();
    var response = await Api.Servicebooking(
        ticketId: servicedata['tt_id'],
        ticketQuantity: servicedata['tk_qty'],
        eventId: servicedata['event_id']);
    hideLoading();
    serviceReserve.clear();
    serviceReserve = json.decode(response.data);
    serviceReserve.addAll(serviceReserve);
    print("Reserved Service : $serviceReserve");
    if (serviceReserve['statuscode'] == 0) {
      await GetStorage().write(
          'balance', serviceReserve['output_available_balance'].toString());
      print("Balance : ${GetStorage().read('balance')}");
      transController.GetHistory();
      Get.offAllNamed('ticketinfo');
    }
    if (serviceReserve['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          serviceReserve['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      authController.logout();
    } else if (serviceReserve['statuscode'] == 3) {
      SnackBar(
          "Error".tr,
          serviceReserve['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    }

    //print(servicedata);
  } //end of Service booking

  //--------------------- Event booking --------------------------//

  Future<void> EventBooking(
      {required String eventID, required EventsCinema eventsCinema}) async {
    showLoading();
    var response = await Api.Eventbooking(eventId: eventID);
    final res = json.decode(response.data);
    hideLoading();
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
    }
    if (res['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      authController.logout();
    } else {
      EventsTicketsList eventsreponse = EventsTicketsList.fromJson(res);
      eventsTickets.clear();
      eventsTickets.addAll(eventsreponse.events);
      print("Events Tickets : $eventsTickets");
      Get.to(
        () => SingleEventScreen(
          eventsCinema: eventsCinema,
        ),
      );
    }
  } //end of Event booking

  void totalPrice(price) {
    total.value = (int.parse(price) * counter.value);
    if (total.value < 0 && counter.value < 0) {
      total.value = 0;
      counter.value = 0;
    }
    print(total);
  }

  void increment(price) {
    counter++;
    totalPrice(price);
  }

  void decrement(price) {
    counter--;
    totalPrice(price);
  }

  void initVar() {
    counter.value = 0;
    total.value = 0;
  }
} //end of Get Services

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
} //end of controller












    // if (counter.value == 0) {
    //   SnackBar(
    //       "Error".tr,
    //       "Sorry".tr,
    //       SvgPicture.asset(
    //         "assets/icons/Close.svg",
    //         color: Colors.white,
    //       ),
    //       error,
    //       SnackPosition.TOP);
    // } else {}