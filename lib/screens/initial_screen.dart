import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//packages
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//provider
import '../providers/google_auth_provider.dart';

//screens
import 'bottom_bar_screen.dart';
import 'auth/intro_auth_screen.dart';

//widgets
import '../widgets/loading_widget.dart';

class InitialScreen extends StatelessWidget {
  static const routeName = '/initialScreen';
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleAuthProvider = Provider.of<GoogleSignInProvider>(context);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print('Data : ' + snapshot.data.toString());

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else if (googleAuthProvider.isSigningIn) {
            return LoadingWidget();
          } else if (snapshot.hasData) {
            return BottomBarScreen();
          } else if (snapshot.hasError) {
            return LoadingWidget();
          }
          return IntroAuthScreen();
        });
  }
}
