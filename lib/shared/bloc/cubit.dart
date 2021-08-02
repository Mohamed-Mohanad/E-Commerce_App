import 'package:final_shop_app/mdules/Categories/categories_screen.dart';
import 'package:final_shop_app/mdules/Favourites/favourit_screen.dart';
import 'package:final_shop_app/mdules/Products/products_screen.dart';
import 'package:final_shop_app/mdules/Settings/settings_screen.dart';
import 'package:final_shop_app/models/Categories/categories_model.dart';
import 'package:final_shop_app/models/Favourites/change_favourites_model.dart';
import 'package:final_shop_app/models/Favourites/favourites_model.dart';
import 'package:final_shop_app/models/Home/home_model.dart';
import 'package:final_shop_app/models/user/login_model.dart';
import 'package:final_shop_app/shared/bloc/states.dart';
import 'package:final_shop_app/shared/components/conestants.dart';
import 'package:final_shop_app/shared/network/end_points.dart';
import 'package:final_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    if(index == 2){
      getFavourites(tokenn: token);
    }else if(index == 3){
      getUserData(tokenn: token);
    }
    emit(ShopChangeBottomNavState());
  }



  HomeModel? homeModel;

  CategoriesModel? categoriesModel;

  FavouritesModel? favouritesModel;

  ChangeFavouritesModel? changeFavouritesModel;

  LoginModel? userModel;

  Map<int, bool?> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);


      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id: element.inFavourites,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavouritesState());
    DioHelper.postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);


      if (!changeFavouritesModel!.status) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavourites();
      }

      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavouritesState(error.toString()));
    });
  }

  void getFavourites({String? tokenn}) {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
      url: FAVOURITES,
      token: tokenn?? token,
    ).then((value) {

      favouritesModel = FavouritesModel.fromJson(value.data);


      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouritesState(error.toString()));
    });
  }

  void getUserData({String? tokenn}) {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: tokenn?? token,
    ).then((value) {
      print(value.data);
      userModel = LoginModel.fromJson(value.data);

      printFullText(userModel!.data!.email.toString());
      emit(ShopSuccessUsersDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateProfileState());
    DioHelper.putData(
      url: UPDATE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: userModel!.data!.token,
    ).then((value) {
      print(value.data);
      userModel = LoginModel.fromJson(value.data);

      printFullText(userModel!.data!.email.toString());
      emit(ShopSuccessUpdaterProfileState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileState(error.toString()));
    });
  }
}
