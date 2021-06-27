import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Tab3 extends StatefulWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
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
