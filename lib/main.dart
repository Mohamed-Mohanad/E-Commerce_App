import 'package:final_shop_app/mdules/Login/login_screen.dart';
import 'package:final_shop_app/mdules/OnBoarding/on_boarding_screen.dart';
import 'package:final_shop_app/mdules/home_layout.dart';
import 'package:final_shop_app/shared/bloc/bloc_observer.dart';
import 'package:final_shop_app/shared/bloc/cubit.dart';
import 'package:final_shop_app/shared/bloc/states.dart';
import 'package:final_shop_app/shared/components/conestants.dart';
import 'package:final_shop_app/shared/network/local/cache_helper.dart';
import 'package:final_shop_app/shared/network/remote/dio_helper.dart';
import 'package:final_shop_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');
  //
  print(token);

  if(onBoarding != null){
    if(token != null){
      widget = HomeScreen();
    }else{
      widget = LoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories()..getUserData()..getFavourites(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            //darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}

//moahmedmohanad0852@gmail.com
//123456789
