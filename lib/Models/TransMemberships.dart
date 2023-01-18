class TransMembershipList {
  final List<TransMemberships> memberships;

  TransMembershipList({required this.memberships});

  factory TransMembershipList.fromJson(Map<String, dynamic> json) {
    return TransMembershipList(
      memberships: parseService(json),
    );
  }

  static List<TransMemberships> parseService(json) {
    var list = json['message'] as List;
    List<TransMemberships> membershipList =
        list.map((data) => TransMemberships.fromJson(data)).toList();
    return membershipList;
  }
}

class TransMemberships {
  TransMemberships({
    this.id,
    this.name,
    this.phone,
    this.serial,
    this.img,
  });

  String? id;
  String? name;
  String? phone;
  String? serial;
  String? img;

  factory TransMemberships.fromJson(Map<String, dynamic> json) =>
      TransMemberships(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        serial: json["serial"],
        img: json["img"],
      );
}






















// class BlogsList {
//   final List<Blogs> blogs;

//   BlogsList({required this.blogs});

//   factory BlogsList.fromJson(Map<String, dynamic> json) {
//     return BlogsList(
//       blogs: parseService(json),
//     );
//   }

//   static List<Blogs> parseService(json) {
//     var list = json['blogsList'] as List;
//     List<Blogs> blogsList = list.map((data) => Blogs.fromJson(data)).toList();
//     return blogsList;
//   }
// }

// class Blogs {
//   Blogs({
//     this.id,
//     this.title,
//     this.date,
//     this.image,
//     this.languageId,
//     this.bcategoryId,
//     this.slug,
//     this.content,
//     this.status,
//     this.metaKeywords,
//     this.metaDescription,
//     this.serialNumber,
//     this.createdAt,
//     this.updatedAt,
//   });

//   String? id;
//   String? title;
//   String? date;
//   String? image;
//   String? languageId;
//   String? bcategoryId;
//   String? slug;
//   String? content;
//   String? status;
//   String? metaKeywords;
//   String? metaDescription;
//   String? serialNumber;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
//         id: json["id"],
//         title: json["title"],
//         date: json["date"],
//         image: json["image"],
//         languageId: json["language_id"],
//         bcategoryId: json["bcategory_id"],
//         slug: json["slug"],
//         content: json["content"],
//         status: json["status"],
//         metaKeywords: json["meta_keywords"],
//         metaDescription: json["meta_description"],
//         serialNumber: json["serial_number"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
// }