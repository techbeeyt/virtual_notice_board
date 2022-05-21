import 'dart:convert';
import 'package:app/views/preview_registration.dart';
import 'package:app/utils/constants.dart';
import 'package:app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late String _fullName, _email, _password, _roll, _confirmPassword;

  void doRegister() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      if (_password.endsWith(_confirmPassword)) {
        setState(() {
          isLoading = true;
        });
        abc();
      } else {
        Flushbar(
          title: "Password mismatch",
          message: "Please enter password correctly",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    } else {
      Flushbar(
        title: "Error",
        message: "Fill in the form properly",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }
  var title = "Login";
  final base = baseUrl;
  final endUrl = '/users';
  var students = [];

  void abc() async {
    var roll = int.parse(_roll[4] + _roll[5] + _roll[6]);
    var _series = _roll[0] + _roll[1];
    var _department = int.parse(_roll[2] + _roll[3]);
    var departmentNames = const [
      'CE',
      'EEE',
      'ME',
      'CSE',
      'ETE',
      'IPE',
      'GCE',
      'URP',
      'MTE',
      'ARCH',
      'ECE',
      'CFPE',
      'BECM',
      'MSE'
    ];
    dynamic _section;
    if (roll >= 001 && roll <= 60) {
      _section = 'A';
    } else if (roll >= 61 && roll <= 120) {
      _section = 'B';
    } else if (roll >= 121 && roll <= 180) {
      _section = 'C';
    }
    try {
      var response = await http.post(
        Uri.http(base, 'users/registration'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "roll": _roll,
          "full_name": _fullName,
          "email": _email,
          "password": _password,
          "series": _series,
          "department": departmentNames[_department],
          "section": _section,
        }),
      );
      var jsonRes = jsonDecode(response.body);
      setState(() {
        isLoading = false;
      });
      if (jsonRes["success"] as bool == true) {
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PreviewReg()));
      } else if (jsonRes["success"] as bool == false) {
        Flushbar(
          title: "Registration Failed",
          message: jsonRes["message"],
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    } catch (err) {
      Flushbar(
        title: "Network Error",
        message: "$err",
        duration: const Duration(seconds: 3),
      ).show(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchData() async {
    try {
      final response = await http.get(Uri.http("10.29.161.157", endUrl));
      final jsonData = jsonDecode(response.body);
      print(response.statusCode);
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
      body: Stack(
        children: [
          Container(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: "OpenSans",
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.blue,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: size.width / 1.25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 10.0,
                              spreadRadius: -10.0),
                        ]),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            "Registration",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autofocus: false,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "This field can't be empty";
                              }
                            },
                            onSaved: (value) => _fullName = (value as String),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              return validateEmail(value as String);
                            },
                            autofocus: false,
                            onSaved: (value) async {
                              var prefs = await SharedPreferences.getInstance();
                              await prefs.setString("email", (value as String));
                              _email = value;

                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            autofocus: false,
                            onSaved: (value) async {
                              var prefs = await SharedPreferences.getInstance();
                              await prefs.setString("roll", (value as String));
                              _roll = value;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.pin),
                              hintText: 'Roll',
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                            ),
                            validator: (String? value) {
                              if (value!.length != 7) {
                                return "Roll must contains 7 numbers (ex: 19xxxxx)";
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Passwords must contain 6 characters";
                              }
                            },
                            obscureText: true,
                            autofocus: false,
                            onSaved: (value) async {
                              var prefs = await SharedPreferences.getInstance();
                              await prefs.setString("email", (value as String));
                              _password = value;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Passwords must contain 6 characters";
                              }
                            },
                            autofocus: false,
                            obscureText: true,
                            onSaved: (value) {
                              _confirmPassword = value as String;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      doRegister();
                    },
                    child: Container(
                      height: 54,
                      width: size.width / 1.25,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 25, 130, 216),
                          borderRadius: BorderRadius.circular(10),
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
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Nunito",
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.white60,
                  child: const SpinKitFoldingCube(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                )
              : const SizedBox(height: 0)
        ],
      ),
    );
  }
}
