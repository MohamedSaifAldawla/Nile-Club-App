// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

class EventCinemaList {
  final List<EventsCinema> eventsCinema;

  EventCinemaList({required this.eventsCinema});

  factory EventCinemaList.fromJson(Map<String, dynamic> json) {
    return EventCinemaList(
      eventsCinema: parseService(json),
    );
  }

  static List<EventsCinema> parseService(json) {
    var list = json['eventList'] as List;
    List<EventsCinema> eventsList =
        list.map((data) => EventsCinema.fromJson(data)).toList();
    return eventsList;
  }
}

class EventsCinema {
  EventsCinema({
    this.id,
    this.title,
    this.details,
    this.location,
    this.startTime,
    this.endTime,
    this.sellStartTime,
    this.sellEndTime,
    this.checkStartTime,
    this.checkEndTime,
    this.status,
    this.img,
    this.catId,
    this.orgId,
    this.addeddate,
    this.name,
    this.email,
  });

  String? id;
  String? title;
  String? details;
  String? location;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? sellStartTime;
  DateTime? sellEndTime;
  DateTime? checkStartTime;
  DateTime? checkEndTime;
  String? status;
  String? img;
  String? catId;
  String? orgId;
  DateTime? addeddate;
  String? name;
  String? email;

  factory EventsCinema.fromJson(Map<String, dynamic> json) => EventsCinema(
        id: json["id"],
        title: json["title"],
        details: json["details"],
        location: json["location"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        sellStartTime: DateTime.parse(json["sellStartTime"]),
        sellEndTime: DateTime.parse(json["sellEndTime"]),
        checkStartTime: DateTime.parse(json["checkStartTime"]),
        checkEndTime: DateTime.parse(json["checkEndTime"]),
        status: json["status"],
        img: json["img"],
        catId: json["cat_id"],
        orgId: json["org_id"],
        addeddate: DateTime.parse(json["addeddate"]),
        name: json["name"],
        email: json["email"],
      );
}
