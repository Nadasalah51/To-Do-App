import 'package:flutter/material.dart';
import 'package:taskey_app/const.dart';
import 'package:taskey_app/screen/auth/screens/register_screen.dart';
import 'package:taskey_app/screen/auth/widgets/inkwell_widget.dart';
import 'package:taskey_app/screen/auth/widgets/text_form_feild_widget.dart';
import 'package:taskey_app/utils/valditor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 122),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff404147),
                ),
              ),
              SizedBox(height: 53),
              Text(
                'email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff404147),
                ),
              ),
              SizedBox(height: 5),
              TextFormFieldWidget(
                controller: email,
                validator: Validator.validateEmail,
                hintText: 'enter email',
              ),
              SizedBox(height: 26),
              Text(
                'password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff404147),
                ),
              ),
              SizedBox(height: 5),
              TextFormFieldWidget(
                controller: password,
                validator: Validator.validatePassword,
                hintText: 'password',
                isPassword: true,
                obscureText: true,
              ),
              SizedBox(height: 71),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  }
                },
                color: themeColor,
                minWidth: double.infinity,
                height: 48,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InKWellWidget(
        title: 'Don’t have an account? ',
        subTitle: 'Register',
        routePath: RegisterScreen.routeName,
      ),
    );
  }
}
