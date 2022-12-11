class User {
  String? id;
  String? name;
  String? phone;
  String? isMember;
  String? token;
  String? account_id;
  String? formid;
  String? serial;
  String? balance;
  String? membership;
  String? img;
  String? exDate;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    phone = json['phone'].toString();
    isMember = json['isMember'].toString();
    token = json['token'].toString();
    account_id = json['account_id'].toString();
    formid = json['formid'].toString();
    serial = json['serial'].toString();
    balance = json['balance'].toString();
    membership = json['membership'].toString();
    img = json['img'].toString();
    exDate = json['ex_date'].toString();
  }
}



















































  // User(
  //     {required this.id,
  //     required this.name,
  //     required this.phone,
  //     required this.token,
  //     required this.isMember});



  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['phone'] = this.phone;
  //   data['token'] = this.token;
  //   data['isMember'] = this.isMember;
  //   return data;
  // }