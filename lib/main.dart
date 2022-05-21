import 'package:shared_preferences/shared_preferences.dart';
import './views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'views/loading_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  final isLogged = prefs.getBool('isLogged') ?? false;

  runApp(MyApp(showHome: showHome, isLogged: isLogged));
}

class MyApp extends StatefulWidget {
  final bool showHome;
  final bool isLogged;
  const MyApp({Key? key, required this.showHome, required this.isLogged}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),

      //determines
      home: widget.showHome
          ? LoadingScreen(
              isLogged: widget.isLogged,
            )
          : const OnBoardingScreen(),
    );
  }
}
