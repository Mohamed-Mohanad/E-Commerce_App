import 'package:final_shop_app/mdules/Login/login_screen.dart';
import 'package:final_shop_app/shared/components/compnents.dart';
import 'package:final_shop_app/shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String? token = CacheHelper.getData(key: 'token');