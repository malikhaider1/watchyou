import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/assets/authwithgoogle.dart';
import 'package:watchyou/assets/signinwithemail.dart';
import 'package:watchyou/screens/signuppage.dart';
import 'package:watchyou/widgets/kroundbutton.dart';

import '../main.dart';
import '../widgets/fieldwidget.dart';

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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 40,
            leading: const BackButton(),
          ),
          backgroundColor: Colors.black,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage('images/background.png'))),
              // ),

              // Expanded(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: 80,
              //         width: 120,
              //         decoration: const BoxDecoration(
              //           image: DecorationImage(
              //               image: AssetImage('images/watchyoulogo.png'),
              //               fit: BoxFit.fitWidth),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Column(
                  children: const [
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
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
                      maximumSize: const Size(278, 48),
                      minimumSize: const Size(278, 48),
                      title: "Login",
                      color: Colors.red,
                      opacity: 0,
                      size: 16,
                      onTap: () {
                        setState(() {
                          if (formKey.currentState!.validate()) {
                            loginUser();
                          }
                        });
                      },
                      borderRadius: 15,
                      textColor: Colors.white,
                    ),
                  ),
                  Padding(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          decoration: const BoxDecoration(
                              border: Border.fromBorderSide(
                                  BorderSide(width: 1, color: Colors.white))),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Or',
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 120,
                          decoration: const BoxDecoration(
                              border: Border.fromBorderSide(
                                  BorderSide(width: 1, color: Colors.white))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: KElevatedButton(
                      maximumSize: const Size(278, 48),
                      minimumSize: const Size(278, 48),
                      title: "Login with Google",
                      color: Colors.blueGrey,
                      opacity: 0,
                      size: 15,
                      onTap: () {
                        signInWithGoogle();
                        navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                      },
                      borderRadius: 15,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
