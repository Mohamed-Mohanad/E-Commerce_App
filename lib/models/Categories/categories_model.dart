class CategoriesModel{
  late bool status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = json['data'] != null ?  CategoriesDataModel.fromJson(json['data']) : null;
  }
}

class CategoriesDataModel{
  late int currentPage;
  List<DataModel> data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel{
  late int id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}