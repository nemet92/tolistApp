import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tolesson/vexana/sign_page_andvexana.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
        ),
        debugShowCheckedModeBanner: false,
        // home: OnBoardingPage(),
        // home: Homepage(text: "toDo"),
        // home: SharedLearnPage(),
        home: const SignPage()
        // home: const UserInfo(),
        );
  }
}
