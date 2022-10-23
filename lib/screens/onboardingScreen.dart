import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watchyou/screens/LoginPage.dart';
import 'package:watchyou/screens/signuppage.dart';
import 'package:watchyou/widgets/kroundbutton.dart';
import 'package:watchyou/widgets/pageView.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/watchyouinnerlogo.png',
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text("Profile",
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade400))),
                  const SizedBox(width: 5),
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.transparent,
                    child: IconButton(
                      hoverColor: primaryColor,
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert_rounded,
                        size: 20,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
            ]),
            // const SizedBox(
            //   height: 20,
            // ),
            const OnBoardingPage(),
            Expanded(
              child: Container(
                  // height: sizeHeight - 854,
                  // width: sizeWidth - 351,
                  height: sizeHeight / (15),
                  width: sizeWidth / (6.8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.6), width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "See what\'s next.",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Material(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  "Watch movies online anywhere \n           anytime you want.",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KElevatedButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignUpScreen()));
                    },
                    size: sizeWidth / 22,
                    color: Colors.transparent.withOpacity(0),
                    opacity: 0.2,
                    title: 'Sign Up',
                    borderRadius: 17,
                    textColor: Colors.white.withOpacity(0.8),
                    minimumSize: Size(sizeHeight / (6.5), sizeWidth / (5.8)),
                    maximumSize: Size(sizeHeight / (6.5), sizeWidth / (5.8)),
                  ),
                  KElevatedButton(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen()));
                      });
                    },
                    size: sizeWidth / 22,
                    opacity: 0,
                    color: Colors.red,
                    title: 'Log In',
                    borderRadius: 17,
                    textColor: Colors.white.withOpacity(0.8),
                    minimumSize: Size(sizeHeight / (6.5), sizeWidth / (5.8)),
                    maximumSize: Size(sizeHeight / (6.5), sizeWidth / (5.8)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
