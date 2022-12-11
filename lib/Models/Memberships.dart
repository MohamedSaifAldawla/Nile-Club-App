class MembershipList {
  final List<Memberships> memberships;

  MembershipList({required this.memberships});

  factory MembershipList.fromJson(Map<String, dynamic> json) {
    return MembershipList(
      memberships: parseService(json),
    );
  }

  static List<Memberships> parseService(json) {
    var list = json['membershipList'] as List;
    List<Memberships> membershipList =
        list.map((data) => Memberships.fromJson(data)).toList();
    return membershipList;
  }
}

class Memberships {
  Memberships({
    this.id,
    this.name,
    this.img,
    this.flagMember,
    this.status,
  });

  String? id;
  String? name;
  String? img;
  String? flagMember;
  String? status;

  factory Memberships.fromJson(Map<String, dynamic> json) => Memberships(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        flagMember: json["flag_member"],
        status: json["status"],
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