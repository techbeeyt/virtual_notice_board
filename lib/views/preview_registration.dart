import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';
import 'loading_screen.dart';

class PreviewReg extends StatefulWidget {
  const PreviewReg({Key? key}) : super(key: key);

  @override
  State<PreviewReg> createState() => _PreviewRegState();
}

class _PreviewRegState extends State<PreviewReg> {
  dynamic series, section;
  @override
  void initState() {
    () async {
      var prefs = await SharedPreferences.getInstance();
      series = prefs.getString("roll");
      section = prefs.getString("section");
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    "Additional Info",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Nunito",
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        spreadRadius: -10,
                        offset: Offset(0, 2)),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "With which series you want to get notices ?",
                    style: TextStyle(fontSize: 18, fontFamily: "Nunito"),
                  ),
                  const Text(
                      "(Change this only if you are a re-admitted student)",
                      style: TextStyle(
                        color: Colors.black54,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Series ($series)",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: "Section ($section)"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: const Text(
                    "SKIP",
                    style: TextStyle(
                      color: Color.fromARGB(255, 69, 87, 96),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isLogged", true);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingScreen(isLogged: true)));
                    } catch (error) {
                      Flushbar(
                        message: error.toString(),
                      ).show(context);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
