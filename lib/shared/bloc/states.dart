

import 'package:final_shop_app/models/Favourites/change_favourites_model.dart';
import 'package:final_shop_app/models/user/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavouritesState extends ShopStates {}

class ShopSuccessChangeFavouritesState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavouritesState(this.error);
}

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {
  final String error;
  ShopErrorGetFavouritesState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUsersDataState extends ShopStates {
  final LoginModel userModel;
  ShopSuccessUsersDataState(this.userModel);
}

class ShopErrorUserDataState extends ShopStates {
  final String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateProfileState extends ShopStates {}

class ShopSuccessUpdaterProfileState extends ShopStates {
  final LoginModel userModel;
  ShopSuccessUpdaterProfileState(this.userModel);
}

class ShopErrorUpdateProfileState extends ShopStates {
  final String error;
  ShopErrorUpdateProfileState(this.error);
}