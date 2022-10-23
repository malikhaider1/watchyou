import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watchyou/screens/LoginPage.dart';
import 'package:watchyou/screens/adminhomescreen.dart';
import 'package:watchyou/screens/homescreen.dart';
import 'package:watchyou/screens/onboardingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: primaryColor,
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    FirebaseAuth.instance.currentUser!.emailVerified) {
                  return const HomeScreen();
                } else {
                  if (snapshot.hasError) {
                    return const ScaffoldMessenger(
                        child: Text('Something Went Wrong'));
                  } else {
                    return const OnBoardingScreen();
                  }
                }
              }),
        ),
        // initialRoute: '/HomeScreen',
        routes: {
          '/loginScreen': (context) => const LoginScreen(),
          '/onBoardingScreen': (context) => const OnBoardingScreen(),
          '/HomeScreen': (context) => const HomeScreen(),
          '/AdminHomeScreen': (context) => const AdminControlHomeScreen(),
        });
  }
}