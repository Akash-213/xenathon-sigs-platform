import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConductSigTab extends StatefulWidget {
  const ConductSigTab({Key? key}) : super(key: key);

  @override
  _ConductSigTabState createState() => _ConductSigTabState();
}

class _ConductSigTabState extends State<ConductSigTab> {
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
