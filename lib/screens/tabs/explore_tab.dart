import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sig_platform/widgets/loading_widget.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    final currUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sigs').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }

          final sigDocs = snapshot.data!.docs;
          print(sigDocs[0]['sigTitle']);
          return ListView.builder(
              itemCount: sigDocs.length,
              itemBuilder: (_, index) {
                return Card(
                  child: Text(sigDocs[index]['sigTitle']),
                );
              });
        });
    ;
  }
}
