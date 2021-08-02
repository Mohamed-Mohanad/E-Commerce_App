import 'package:final_shop_app/shared/bloc/cubit.dart';
import 'package:final_shop_app/shared/bloc/states.dart';
import 'package:final_shop_app/shared/components/compnents.dart';
import 'package:final_shop_app/shared/components/conestants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var model = ShopCubit.get(context).userModel;

        if(model != null){
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        }


        return cubit.userModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateProfileState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateUserData(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'update',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          function: () {
                            signOut(context);
                          },
                          text: 'logout',
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
