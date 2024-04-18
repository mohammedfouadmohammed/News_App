import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../modules/news_app/web_view_screen/web_view_screen.dart';


Widget defaultButton(
    {
   double width = double.infinity,
   Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  required void Function() function,
  required String text,
}) => Container(
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      // ignore: prefer_const_constructors
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultTextButton({
  required void Function() function,
  required String text,
})=>TextButton(
  onPressed: function,
  child: Text(text),
);

Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  Function()? suffixPressed,
  IconData? suffix,
  bool isClickable = true,
}) => TextFormField(
keyboardType: type,
controller: controller,
  obscureText: isPassword,
enabled: isClickable,
onFieldSubmitted: onSubmit,
onChanged: onChange,
onTap: onTap,
validator: validate,
decoration: InputDecoration(
labelText: label,
border: const OutlineInputBorder(),
prefixIcon: Icon(
prefix,
),
    suffixIcon: suffix!=null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) : null,
),
);

Widget myDivider() => Padding(
padding: const EdgeInsetsDirectional.only(
start: 20.0,
),
child: Container(
width: double.infinity,
height: 1.0,
color: Colors.grey[300],
),
);

Widget buildArticleItem (article , context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 110.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0, //state is! NewsGetBusinessLoadingState,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index],context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 10,
  ),
  fallback: (context) => isSearch? Container() : Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget,) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget,) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic> route) => false,
);

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastCollor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

//enum
enum ToastStates {SUCCESS,ERROR,WARNING}

Color? chooseToastCollor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color =  Colors.blue;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
