import 'package:firebase_app/src/pages/login_page.dart';
import 'package:firebase_app/src/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
 class  MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: " firebase ",
          theme:  ThemeData(
            // primarySwatch: Colors.black,

          ),
home: LoginPage(),


    );
  }


}