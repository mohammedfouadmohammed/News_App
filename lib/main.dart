import 'package:first_app/layout/news_app/cubit/cubit.dart';
import 'package:first_app/layout/news_app/news_layout.dart';
import 'package:first_app/shared/Network/local/cache_helper.dart';
import 'package:first_app/shared/Network/remote/dio_helper.dart';
import 'package:first_app/shared/block_observe.dart';
import 'package:first_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



void main() async {
  //بيتاكد ان كل حاجة هنا في الميثود خلصت وبعدين يفتح الاب
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(Myapp(isDark: isDark!,));//
}
//  StatelessWidget
// StatefulWidget
class Myapp extends StatelessWidget//this come  from library 'package:flutter/material.dart' calling from (important)
    {
  final bool isDark;
  const Myapp({super.key,
    required this.isDark,
  });
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>  NewsCubit()..getBusiness()..getSports()..getScience(), ),
        BlocProvider(create: (BuildContext context) => AppsCubit()..changeAppMode(fromShared: isDark,),),
      ],
      child: BlocConsumer<AppsCubit, AppStates>(
        listener: (context, state) {  },
        builder: (context, state) {
          return MaterialApp(
            debugShowMaterialGrid: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}