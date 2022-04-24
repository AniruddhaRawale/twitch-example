import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone_final/resources/auth_methods.dart';
import 'package:flutter_twitch_clone_final/responsive/responsive.dart';
import 'package:flutter_twitch_clone_final/screens/home_screen.dart';
import 'package:flutter_twitch_clone_final/widgets/custom_button.dart';
import 'package:flutter_twitch_clone_final/widgets/customtextfield.dart';
import 'package:flutter_twitch_clone_final/widgets/loading_indicator.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  bool _isloading = false;

  loginUser() async {
    setState(() {
      _isloading = true;
    });
    bool res = await _authMethods.loginUser(
        context, _emailcontroller.text, _passwordcontroller.text);
    setState(() {
      _isloading = false;
    });
    if(res){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose(){
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: _isloading?const LoadingIndicator():Responsive(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(controller: _emailcontroller),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(controller: _passwordcontroller),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(onTap: loginUser, text: "Log In")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
