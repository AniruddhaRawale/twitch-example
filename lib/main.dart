import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone_final/Providers/user_provider.dart';
import 'package:flutter_twitch_clone_final/Utills/colors.dart';
import 'package:flutter_twitch_clone_final/resources/auth_methods.dart';
import 'package:flutter_twitch_clone_final/screens/home_screen.dart';
import 'package:flutter_twitch_clone_final/screens/login_screen.dart';
import 'package:flutter_twitch_clone_final/screens/onboarding_screen.dart';
import 'package:flutter_twitch_clone_final/screens/signup_screen.dart';
import 'package:flutter_twitch_clone_final/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_twitch_clone_final/models/user.dart' as model;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAkMxJuToRvxNnxuhFP_jJoo5_oAdS4ttk",
            authDomain: "twitch-clone-6f15d.firebaseapp.com",
            projectId: "twitch-clone-6f15d",
            storageBucket: "twitch-clone-6f15d.appspot.com",
            messagingSenderId: "910515209309",
            appId: "1:910515209309:web:318f3520a3fe33ba2af9b4",
            measurementId: "G-98CYF905Y0"
        )
    );
  }else{
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Twitch Clone Tutorial",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme.of(context).copyWith(
                backgroundColor: backgroundColor,
                elevation: 0,
                titleTextStyle: const TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
                iconTheme: const IconThemeData(color: primaryColor)
            )

        ),
        routes: {
          OnboardingScreen.routeName:(context) => const OnboardingScreen(),
          LoginScreen.routeName:(context) => const LoginScreen(),
          SignUpScreen.routeName:(context) => const SignUpScreen(),
          HomeScreen.routeName:(context) => const HomeScreen(),
        },
        home: FutureBuilder(
          future: AuthMethods().getCurrentUser(FirebaseAuth.instance.currentUser != null ?FirebaseAuth.instance.currentUser!.uid:null).then((value) {
            if(value != null){
              Provider.of<UserProvider>(context,listen: false).setUser(model.User.fromMap(value));
            }
            return value;
          }),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const LoadingIndicator();
            }
            if(snapshot.hasData){
              return HomeScreen();
            }
            return const OnboardingScreen();
          },
        )
    );
  }
}
