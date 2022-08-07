import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_app/registration/registration.dart';
import 'package:pet_perfect_app/screens/Info/bloc/info_bloc.dart';
import 'package:pet_perfect_app/simple_bloc_observer.dart';
import 'package:pet_perfect_app/splash/view/splash_page.dart';
import 'package:pet_perfect_app/initial_profile/view/view.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';
import 'common/bottom_navigator.dart';
import 'package:pet_perfect_app/initial_profile/bloc/initial_profile_bloc.dart';
import 'authentication/bloc/authentication_bloc.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'home/bloc/export.dart';
import 'profile/bloc/pet_profile_bloc.dart';
import 'screens/Food/bloc/food_bloc.dart';
import 'services/bloc/services_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //Bloc.observer = SimpleBlocObserver();

    return BlocProvider(
      create: (context) => AuthenticationBloc(AuthenticationUnintializedState())
        ..add(AuthenticationAppStartEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, // set to true to see the debug banner
        title: 'Pet Perfect',
        theme: //AppThemes.appThemeData[AppTheme.lightTheme],
            ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 16.0),
            bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    BlocProvider.of<AuthenticationBloc>(context)),
            BlocProvider(create: (context) => HomeBloc()),
            BlocProvider(create: (context) => FoodBloc()),
            BlocProvider(create: (context) => ServicesBloc()),
            BlocProvider(create: (context) => InsightsBloc()),
            BlocProvider(create: (context) => PetProfileBloc()),
          ],
          child: BottomNavigatorPage(),
        ),
      ),
    );
  }
}
