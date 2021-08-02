import 'package:final_shop_app/mdules/Login/login_cubit.dart';
import 'package:final_shop_app/mdules/Login/login_states.dart';
import 'package:final_shop_app/mdules/Register/register_screen.dart';
import 'package:final_shop_app/mdules/home_layout.dart';
import 'package:final_shop_app/shared/bloc/cubit.dart';
import 'package:final_shop_app/shared/components/compnents.dart';
import 'package:final_shop_app/shared/components/conestants.dart';
import 'package:final_shop_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(
                  context,
                  HomeScreen(),
                );

                showToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.SUCCESS,
                );
              });
            } else {
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message.toString(),
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            isPassword: cubit.isPassword,
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is! ShopLoginLoadingState
                            ? defaultButton(
                                isUpperCase: true,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'login',
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\`t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  RegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
