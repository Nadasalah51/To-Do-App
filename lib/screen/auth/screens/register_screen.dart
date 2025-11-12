import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskey_app/const.dart';
import 'package:taskey_app/screen/auth/screens/login_screen.dart';
import 'package:taskey_app/screen/auth/widgets/inkwell_widget.dart';
import 'package:taskey_app/screen/auth/widgets/text_form_feild_widget.dart';
import 'package:taskey_app/utils/app_dialog.dart';
import 'package:taskey_app/utils/valditor.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register_screen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var fullName = TextEditingController();
  var confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
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
              SizedBox(height: 97),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff404147),
                ),
              ),
              SizedBox(height: 53),
              Text(
                'UserName',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff404147),
                ),
              ),
              SizedBox(height: 5),
              TextFormFieldWidget(
                controller: fullName,
                validator: Validator.validateName,
                hintText: 'enter userName',
              ),
              SizedBox(height: 26),
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
              SizedBox(height: 26),
              Text(
                'confirm password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff404147),
                ),
              ),
              SizedBox(height: 5),
              TextFormFieldWidget(
                controller: confirmPassword,
                validator: (text) {
                  return Validator.validateConfirmPassword(text, password.text);
                },
                hintText: 'confirm password',
                isPassword: true,
                obscureText: true,
              ),

              SizedBox(height: 71),
              MaterialButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    AppDialog.showLoading(context);
                    await register(email: email.text, password: password.text)
                        .then((value) {
                          Navigator.of(context).pop();
                          fullName.clear();
                          email.clear();
                          password.clear();
                          confirmPassword.clear();
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(LoginScreen.routeName);
                        })
                        .catchError((error) {
                          Navigator.of(context).pop();
                          AppDialog.showError(context, error: error);
                        });
                  }
                },
                color: themeColor,
                minWidth: double.infinity,
                height: 48,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
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
        title: 'Already have an account? ',
        subTitle: 'Login',
        routePath: LoginScreen.routeName,
      ),
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => print('add user'))
          .catchError((value) => print('error'));
    } catch (e) {
      throw 'Error from firebaseexseption';
    }
  }
}
