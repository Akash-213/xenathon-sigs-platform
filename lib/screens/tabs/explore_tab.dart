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
                          elevation: 8,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade50,
                                  Colors.purple.shade200
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
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
                                      'Title ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      sigDocs[index]['sigTitle'],
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Description ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Text(sigDocs[index]['sigDesc'],
                                    overflow: TextOverflow.clip),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Host  ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      sigDocs[index]['sigByName'],
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Host Proficiency ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      sigDocs[index]['proficiency'],
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
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
}
