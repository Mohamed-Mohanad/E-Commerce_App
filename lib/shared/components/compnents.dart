import 'package:final_shop_app/shared/bloc/cubit.dart';
import 'package:final_shop_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultFormField({
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) {
  return TextFormField(
    enabled: isClickable,
    obscureText: isPassword,
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: (s) {
      onSubmit!(s);
    },
    onChanged: (s) {
      if (onChange != null) {
        onChange(s);
      }
    },
    onTap: () {
      if (onTap != null) {
        onTap();
      }
    },
    validator: (ss) {
      validate(ss);
    },
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: () {
                suffixPressed!();
              },
              icon: Icon(
                suffix,
              ),
            )
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) {
  return Container(
    width: width,
    child: MaterialButton(
      onPressed: () {
        function();
      },
      color: Colors.blueAccent,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      height: 50.0,
    ),
  );
}

Widget defaultTextButton({required Function function, required String text}) {
  return TextButton(
    onPressed: () {
      function();
    },
    child: Text(
      text.toUpperCase(),
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

Future<void> showMyDialog({
  required Text title,
  required Text message,
  required BuildContext context,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              message,
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.deepOrange),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

//SHOW TOAST
enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    '${model!.image}',
                  ),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavourites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favourites[model.id] ??
                                      false
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
