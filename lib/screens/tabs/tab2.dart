import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    final currUser = FirebaseAuth.instance.currentUser!;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(currUser.photoURL ?? ''),
            ),
            Text(
              currUser.displayName ?? 'DisplayName',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              currUser.email ?? 'Email',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
