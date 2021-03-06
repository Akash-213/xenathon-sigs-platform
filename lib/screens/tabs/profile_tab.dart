import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final currUser = FirebaseAuth.instance.currentUser!;
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(currUser.photoURL ?? ''),
            ),
            SizedBox(height: 30),
            Text(
              currUser.displayName ?? 'DisplayName',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 30),
            Text(
              currUser.email ?? 'Email',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Container(
              child: Text('More Sections Coming Up Soon'),
            )
          ],
        ),
      ),
    );
  }
}
