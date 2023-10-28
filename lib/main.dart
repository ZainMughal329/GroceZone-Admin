import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/material.dart';
import 'package:groce_zone_admin/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCY-ghq3F_ohujHV_NQ2ENn8aP4YmJo2j4",
        authDomain: "grocery-app-bed5a.firebaseapp.com",
        projectId: "grocery-app-bed5a",
        storageBucket: "grocery-app-bed5a.appspot.com",
        messagingSenderId: "287411568147",
        appId: "1:287411568147:web:f5bcd21c4b1868117309e6",
        measurementId: "G-LBXWDB21TC"),
  );

  // await FirebaseAppWeb
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        ///kldsajflksjdflksdj
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SiteLayout(),
    );
  }
}

