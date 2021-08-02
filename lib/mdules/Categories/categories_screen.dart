import 'package:final_shop_app/models/Categories/categories_model.dart';
import 'package:final_shop_app/shared/bloc/cubit.dart';
import 'package:final_shop_app/shared/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return cubit.categoriesModel != null ? ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        ) : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      );
}
