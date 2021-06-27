import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sig_platform/providers/google_auth_provider.dart';
import 'package:sig_platform/screens/auth/intro_auth_screen.dart';
import 'package:sig_platform/screens/bottom_bar_screen.dart';
import 'package:sig_platform/screens/initial_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase initialized
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'SIGs',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Raleway',
            iconTheme: IconTheme.of(context).copyWith(
              color: Colors.white,
            )),
        home: InitialScreen(),
      ),
    );
  }
}
