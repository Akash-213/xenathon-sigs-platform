import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sig_platform/screens/sig_details.dart';
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
          //print(sigDocs[0]['sigTitle']);
          return ListView.builder(
              itemCount: sigDocs.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      print('hello');
                      print(sigDocs[index]['topics']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  title: sigDocs[index]['sigTitle'],
                                  topics: sigDocs[index]['topics'],
                                  proficiency: sigDocs[index]['proficiency'],
                                  datetime:
                                      sigDocs[index]['sigDateTime'].toString(),
                                  desc: sigDocs[index]['sigDesc'],
                                  by: sigDocs[index]['sigBy'],
                                )),
                      );
                    });
                  },
                  // child: Card(
                  //   clipBehavior: Clip.antiAlias,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(24),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  //         child: Text(
                  //           'Title: ' + sigDocs[index]['sigTitle'],
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  //         child: Text(
                  //           'Description: ' + sigDocs[index]['sigDesc'],
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  //         child: Text(
                  //           'Conducted By: ' + sigDocs[index]['sigBy'],
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ),

                  //     ],
                  //   ),
                  // ),
                  child: Card(
                    shadowColor: Colors.purple,
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade100,
                            Colors.purple.shade300
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16).copyWith(bottom: 0),
                            child: Text(
                              'Title: ' + sigDocs[index]['sigTitle'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16).copyWith(bottom: 0),
                            child: Text(
                              'Description: ' + sigDocs[index]['sigDesc'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16).copyWith(bottom: 0),
                            child: Text(
                              'Conducted By: ' + sigDocs[index]['sigBy'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
