import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sig_platform/widgets/loading_widget.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  _ScheduleTabState createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  @override
  Widget build(BuildContext context) {
    final currUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sigs')
            .where('isConfirmed', isEqualTo: true)
            .snapshots(),
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
  }
}
