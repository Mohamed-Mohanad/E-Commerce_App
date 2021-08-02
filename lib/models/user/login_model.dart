class LoginModel{
  late bool status;
  String? message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic>json){
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData{
  late int id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;

  //named constructor
  UserData.fromJson(Map<String, dynamic>json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    points = json['points'];
    credit = json['credit'];
  }

}