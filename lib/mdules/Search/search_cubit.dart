

import 'package:final_shop_app/mdules/Search/search_state.dart';
import 'package:final_shop_app/models/Search/search_model.dart';
import 'package:final_shop_app/shared/components/conestants.dart';
import 'package:final_shop_app/shared/network/end_points.dart';
import 'package:final_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value){
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState(error.toString()));
    });
  }
}
