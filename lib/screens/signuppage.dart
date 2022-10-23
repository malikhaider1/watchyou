import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchyou/assets/authwithgoogle.dart';
import 'package:watchyou/assets/signinwithemail.dart';
import 'package:watchyou/widgets/kroundbutton.dart';

import '../main.dart';
import '../widgets/fieldwidget.dart';
import '../widgets/topbar.dart';
import 'LoginPage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }

  void signUpUser() async {
    EmailSignUp(FirebaseAuth.instance).signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/background.png'))),
              ),
              const kTopBar(),
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
                          return 'Min 8 characters';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      hintText: "Password",
                      labelText: 'Password'),
                  const SizedBox(
                    height: 25,
                  ),
                  KFieldWidget(
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value != passwordController.text.trim()) {
                          return "Password didn't match";
                        }
                        return null;
                      },
                      controller: confirmController,
                      hintText: "Confirm Password",
                      labelText: "Confirm Password"),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: KElevatedButton(
                      maximumSize: const Size(260, 60),
                      minimumSize: const Size(260, 60),
                      title: "Sign Up",
                      color: primaryColor,
                      opacity: 0,
                      size: 17,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          return signUpUser();
                        }
                      },
                      borderRadius: 25,
                      textColor: Colors.black,
                    ),
                  ),
                  Text(
                    'or',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: KElevatedButton(
                      maximumSize: const Size(260, 60),
                      minimumSize: const Size(260, 60),
                      title: "SignUp with Google",
                      color: primaryColor,
                      opacity: 0,
                      size: 17,
                      onTap: () {
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
                        'Already an account?',
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
                                        const LoginScreen()));
                          },
                          child: Text(
                            'Log In',
                            style: TextStyle(color: primaryColor, fontSize: 17),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
