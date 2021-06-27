import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sig_platform/screens/sig_details.dart';
import 'package:sig_platform/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
          return sigDocs.length == 0
              ? Center(child: Text('Sigs Coming Up Soon ... Stay Tuned'))
              : ListView.builder(
                  itemCount: sigDocs.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                sigId: sigDocs[index].id,
                              ),
                            ),
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shadowColor: Colors.purple,
                          elevation: 10,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade50,
                                  Colors.purple.shade200
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Title',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(sigDocs[index]['sigTitle']),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Description ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800)),
                                    Text(sigDocs[index]['sigDesc'])
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Host ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800)),
                                    Text(sigDocs[index]['sigByName']),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Date of SIG",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800)),
                                    Text(DateFormat.jms().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            sigDocs[index]['sigDateTime']
                                                    .seconds *
                                                1000))),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Time of SIG',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800)),
                                    Text(DateFormat.yMMMEd()
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                sigDocs[index]['sigDateTime']
                                                        .seconds *
                                                    1000))
                                        .toString()),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  child: Text('Join Now'),
                                  onPressed: () async {
                                    _launchURL(sigDocs[index]['sigLink']);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
