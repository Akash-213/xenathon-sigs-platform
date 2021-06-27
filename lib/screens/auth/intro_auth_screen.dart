import 'package:flutter/material.dart';

//packages
import 'package:provider/provider.dart';

//providers
import '/providers/google_auth_provider.dart';

//widgets

class IntroAuthScreen extends StatefulWidget {
  static const routeName = '/intro-auth';
  const IntroAuthScreen({Key? key}) : super(key: key);

  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SIGs Platform'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Google Sign In'),
              onPressed: () async {
                await Provider.of<GoogleSignInProvider>(context, listen: false)
                    .googleLogIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
