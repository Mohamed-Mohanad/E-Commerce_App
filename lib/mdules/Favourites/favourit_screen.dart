import 'package:final_shop_app/models/Favourites/favourites_model.dart';
import 'package:final_shop_app/shared/bloc/cubit.dart';
import 'package:final_shop_app/shared/bloc/states.dart';
import 'package:final_shop_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return cubit.favouritesModel != null
            ? cubit.favouritesModel!.data!.data.length == 0
                ? emptyFav()
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildFavItem(
                      cubit.favouritesModel!,
                        index,
                        context,
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius:
                          BorderRadiusDirectional.circular(35.0),
                        ),
                      ),
                    ),
                    itemCount: cubit
                        .favouritesModel!
                        .data!
                        .data
                        .length,
                  )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

Widget emptyFav() => Center(
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'No Favourites Items',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'Add Some',
            style: TextStyle(color: defaultColor),
          ),
        ]),
      ),
    );


Widget buildFavItem(FavouritesModel? model, int index, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                height: 120,
                width: 120,
                image: NetworkImage(model!.data!.data[index].product!.image.toString()),
              ),
              // if (model.data.products[index].discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: Text(
                  'خصم',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.data!.data[index].product!.name.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, height: 1.3),
              ),
              Row(
                children: [
                  Text(
                    model.data!.data[index].product!.price
                        .round()
                        .toString() +
                        ' ج.م ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.0, height: 1.3, color: defaultColor),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  // if (model.data.products[index].discount != 0)
                  Text(
                    model.data!.data[index].product!.oldPrice
                        .round()
                        .toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 10.0,
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                  Spacer(),
                  IconButton(
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favourites[model.data!.data[index].id]??false
                            ? defaultColor
                            : Colors.blue,
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        ShopCubit.get(context).changeFavourites(
                          model.data!.data[index].product!.id,
                        );
                      })
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);
