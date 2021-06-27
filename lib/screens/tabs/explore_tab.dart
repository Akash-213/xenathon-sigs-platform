import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
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