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
            Center(
                child: Text(
              'SIGs Platform',
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(height: 50),
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
