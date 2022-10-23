import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/assets/signinwithemail.dart';
import 'package:watchyou/screens/signuppage.dart';
import 'package:watchyou/widgets/kroundbutton.dart';

import '../assets/authwithgoogle.dart';
import '../main.dart';
import '../widgets/fieldwidget.dart';
import '../widgets/topbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// MaterialColor primaryColor = MaterialColor(0xFFFFBD59, color);

Color primaryColor = Colors.blueGrey;

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void loginUser() {
    EmailSignUp(FirebaseAuth.instance).loginInWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Material(
          color: Colors.black,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'))),
                ),
                const kTopBar(),
                // SizedBox(
                //   height: 30,
                // ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/watchyoulogo.png'),
                              fit: BoxFit.fitWidth),
                        ),
                      )
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    KFieldWidget(
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) {
                        if (email != null && !EmailValidator.validate(email)) {
                          return "Enter a valid email";
                        } else {}
                        return null;
                      },
                      controller: emailController,
                      hintText: "example@email.com",
                      labelText: "Email",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    KFieldWidget(
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != null && value.length < 8) {
                            return 'Enter correct Password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        hintText: "Password",
                        labelText: 'Password'),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 10),
                      child: KElevatedButton(
                        maximumSize: const Size(260, 60),
                        minimumSize: const Size(260, 60),
                        title: "Login",
                        color: primaryColor,
                        opacity: 0,
                        size: 17,
                        ontap: () {
                          setState(() {
                            if (formKey.currentState!.validate()) {
                              loginUser();
                            }
                          });
                        },
                        borderRadius: 25,
                        textColor: Colors.black,
                      ),
                    ),
                    Text(
                      'or',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: KElevatedButton(
                        maximumSize: const Size(260, 60),
                        minimumSize: const Size(260, 60),
                        title: "Login with Google",
                        color: primaryColor,
                        opacity: 0,
                        size: 17,
                        ontap: () {
                          signInWithGoogle();
                          navigatorKey.currentState!
                              .popUntil((route) => route.isFirst);
                        },
                        borderRadius: 25,
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Create account?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const SignUpScreen()));
                            },
                            child: Text(
                              'Sign up',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 17),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}