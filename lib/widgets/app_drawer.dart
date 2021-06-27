import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final currUser = FirebaseAuth.instance.currentUser!;

    return Container(
      width: screenSize.width * 0.4,
      child: Drawer(
        child: Container(
          child: Text('App Drawer'),
        ),
      ),
    );
  }
}
