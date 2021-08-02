import 'package:bloc/bloc.dart';
import 'package:final_shop_app/mdules/Register/register_states.dart';
import 'package:final_shop_app/models/user/login_model.dart';
import 'package:final_shop_app/shared/components/conestants.dart';


import 'package:final_shop_app/shared/network/end_points.dart';
import 'package:final_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
