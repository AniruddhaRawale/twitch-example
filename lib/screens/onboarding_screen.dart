import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone_final/responsive/responsive.dart';
import 'package:flutter_twitch_clone_final/screens/signup_screen.dart';
import 'package:flutter_twitch_clone_final/widgets/custom_button.dart';

import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Responsive(
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             const Text("Welcome to \nTwitch",style: const TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 40
             ),
             textAlign: TextAlign.center,
             ),
             const SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: CustomButton(onTap: (){
                 Navigator.pushNamed(context, LoginScreen.routeName);
               }, text: "Log In"),
             ),
             CustomButton(onTap: (){
               Navigator.pushNamed(context, SignUpScreen.routeName);
             }, text: "Sign Up")
           ],
         ),
       ),
     ),
    );
  }
}
