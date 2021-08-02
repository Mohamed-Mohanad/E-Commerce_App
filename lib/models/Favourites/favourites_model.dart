class FavouritesModel {
  late bool status;
  Data? data;


  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']) ;
  }


}

class Data {
  int? currentPage;
  List<FavouritesData> data = [];


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new FavouritesData.fromJson(v));
      });
    }
  }


}

class FavouritesData {
  late int id;
  Product? product;


  FavouritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
