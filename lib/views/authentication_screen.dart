import 'dart:convert';
import 'package:app/views/recover_password_screen.dart';
import 'package:app/views/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var title = "Login";
  final base_url = '10.29.43.86:3000';
  final end_url = '/users';
  var students = [];

  void abc() async {
    try {
      var response = await http.post(
        Uri.http(base_url, 'users/registration'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "roll": "1902312322",
          "full_name": "Montasir",
          "email": "mmc23se19ww@gmail.cc",
          "password": "123456",
          "series": "19",
          "department": "CSE",
          "section": "B"
        }),
      );
      print(response.body);
    } catch (err) {
      print(err);
    }
  }

  void fetchData() async {
    try {
      final response = await http.get(Uri.http(base_url, end_url));
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      setState(() {
        students = jsonData;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  initState() {
    super.initState();
    fetchData();
  }

  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: size.height,
        child: Stack(
          children: [
            Container(
              height: size.height / 2,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topRight,
                      colors: [
                    Color.fromARGB(255, 34, 115, 181),
                    Colors.blueAccent,
                  ])),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegScreen()));
                  },
                  child: Row(
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white.withAlpha(240),
                          fontFamily: "OpenSans",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: size.height / 9,
                left: size.width / 2 - 50,
                child: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.white,
                  size: 100,
                )),
            Positioned(
              top: size.height / 3.2,
              left: size.width / 2 - size.width / 2.5,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: size.width / 1.25,
                height: size.height / 3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 10.0,
                          spreadRadius: -10.0),
                    ]),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontFamily: "Nunito",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontFamily: "Nunito",
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height / 3.2 + size.height / 3 - 27,
              left: size.width / 2 - size.width / 4,
              child: Container(
                height: 54,
                width: size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 2.0),
                        blurRadius: 10,
                        spreadRadius: -9,
                      ),
                    ]),
                child: const Center(
                    child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Positioned(
              top: size.height / 2 + size.height / 5,
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                height: size.height / 5,
                width: size.width,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RecoverScreen()));
                    },
                    child: const Text(
                      "FORGOT PASSWORD ?",
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "OpenSans",
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
