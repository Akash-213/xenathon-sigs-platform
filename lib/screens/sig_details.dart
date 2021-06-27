import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sig_platform/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final String sigId;
  const DetailsPage({required this.sigId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late bool isInterested;

  bool isCountEqual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SIG Details')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sigs')
            .doc(widget.sigId)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }

          final snapshotDoc = snapshot.data!;

          if (snapshotDoc.get('interestedCount') ==
              snapshotDoc.get('sigCount')) {
            isCountEqual = true;
          }

          print(isCountEqual);
          if (snapshotDoc.get('interestedCount') ==
              snapshotDoc.get('sigCount')) {
            print('this is working');
            FirebaseFirestore.instance
                .collection('sigs')
                .doc(widget.sigId)
                .update({'isConfirmed': true});
          }

          return Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title : ' + snapshotDoc.get('sigTitle'),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1.5),
                  SizedBox(height: 20),
                  Text(
                    'Description: ' + snapshotDoc.get('sigDesc'),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1.5),
                  SizedBox(height: 20),
                  Text(
                    'Conducted By: ' + snapshotDoc.get('sigByName'),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Proficiency of Host : ' + snapshotDoc.get('proficiency'),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1.5),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date of SIG"),
                      Text(DateFormat.jms().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              snapshotDoc.get('sigDateTime').seconds * 1000))),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time of SIG'),
                      Text(DateFormat.yMMMEd()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              snapshotDoc.get('sigDateTime').seconds * 1000))
                          .toString()),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1.5),
                  SizedBox(height: 20),
                  Text('Topics : '),
                  Text(
                    snapshotDoc.get('topics'),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1.5),
                  SizedBox(height: 20),
                  Text('Registered Enthusiasts Count : ' +
                      snapshotDoc.get('interestedCount').toString()),
                  Text('Join Now would be activated after : ' +
                      (snapshotDoc.get('sigCount') -
                              snapshotDoc.get('interestedCount'))
                          .toString() +
                      ' entries'),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Text('Join Now'),
                        onPressed: isCountEqual
                            ? () async {
                                _launchURL(snapshotDoc.get('sigLink'));
                              }
                            : null,
                      ),
                      ElevatedButton(
                        child: Text('Interested'),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('sigs')
                              .doc(widget.sigId)
                              .update({
                            'interestedCount':
                                snapshotDoc.get('interestedCount') + 1
                          });

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('interestedSigs')
                              .doc(widget.sigId)
                              .set({
                            'sigId': widget.sigId,
                            'sigTitle': snapshotDoc.get('sigTitle'),
                          });

                          print(snapshotDoc.get('interestedCount'));
                          print(snapshotDoc.get('sigCount'));
                          if (snapshotDoc.get('interestedCount') ==
                              snapshotDoc.get('sigCount')) {
                            print('this is working');
                            await FirebaseFirestore.instance
                                .collection('sigs')
                                .doc(widget.sigId)
                                .update({'isConfirmed': true});
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
