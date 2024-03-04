import 'package:app1/bloc/authorization/authorization_bloc.dart';
import 'package:app1/bloc/eating_food_bloc/eating_food_bloc.dart';
import 'package:app1/bloc/food_bloc/food_bloc.dart';
import 'package:app1/bloc/registration/registration_bloc.dart';
import 'package:app1/bloc/user_image_bloc/user_image_bloc.dart';
import 'package:app1/bloc/user_info_bloc/user_info_bloc.dart';
import 'package:app1/constants.dart';
import 'package:app1/cubit/get_page_cubit.dart';
import 'package:app1/enums/sex.dart';
import 'package:app1/models/eating_food.dart';
import 'package:app1/models/food.dart';
import 'package:app1/models/user.dart';
import 'package:app1/router/router.dart';
import 'package:app1/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

///TODO | ИЗМЕНИТЬ ПИСЬМО ПРИХОДЯЩЕЕ НА ПОЧТУ | Сделать валидацию при регистрации |
///TODO Сделать везде проверку на инет и вылет окна ошибки(Делать с помощью структуры
///TODO try catch(throw))
///TODO При редакстировании еды, создаётся новая или нет(нужно потестить и разобраться)


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(0)){
    Hive.registerAdapter(AppUserAdapter());
  }
  if(!Hive.isAdapterRegistered(1)){
    Hive.registerAdapter(FoodAdapter());
  }
  if(!Hive.isAdapterRegistered(2)){
    Hive.registerAdapter(EatingFoodAdapter());
  }
  if(!Hive.isAdapterRegistered(3)){
    Hive.registerAdapter(SexAdapter());
  }
  runApp(MyFitnessApp());
}


class MyFitnessApp extends StatelessWidget {
  MyFitnessApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    addScreenSize(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserInfoBloc>(
              create: (BuildContext context) => UserInfoBloc()
          ),
          BlocProvider<AuthorizationBloc>(
              create: (BuildContext context) => AuthorizationBloc()
          ),
          BlocProvider<GetPageCubit>(
              create: (BuildContext context) => GetPageCubit()
          ),
          BlocProvider<UserImageBloc>(
              create: (BuildContext context) => UserImageBloc()
          ),
          BlocProvider<FoodBloc>(
              create: (BuildContext context) => FoodBloc()
          ),
          BlocProvider<EatingFoodBloc>(
              create: (BuildContext context) => EatingFoodBloc()
          ),
          BlocProvider<RegistrationBloc>(
              create: (BuildContext context) => RegistrationBloc()
          )
        ],
        child: MaterialApp.router(
          theme: createTheme(),
          debugShowCheckedModeBanner: false,
          //home: const StartPage(),
          routerConfig: _appRouter.config(),
        )
    );
  }
}

