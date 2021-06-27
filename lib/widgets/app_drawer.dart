import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sig_platform/screens/developersDetails.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final currUser = FirebaseAuth.instance.currentUser!;

    return Container(
        width: screenSize.width * 0.6,
        child: SafeArea(
          child: Drawer(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(currUser.photoURL ?? ''),
                        backgroundColor: Colors.purple.shade200,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 0.1,
                ),
                Expanded(
                  child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                        title: Text(
                          'Developers',
                          style: TextStyle(fontSize: 23.0),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Developers()),
                          );
                          //Navigator.pop(context);
                        }),
                  ]),
                ),
                Divider(thickness: 2),
                Container(
                    padding: EdgeInsets.all(10),
                    height: 50,
                    child: Text(
                      "XENATHON",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ))
              ],
            ),
          ),
        ));
  }
}
