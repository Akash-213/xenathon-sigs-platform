import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String title, desc, topics, datetime, by, proficiency;
  const DetailsPage(
      {required this.title,
      required this.desc,
      required this.topics,
      required this.datetime,
      required this.by,
      required this.proficiency});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.title);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Card(
              shadowColor: Colors.purple,
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: EdgeInsets.all(16).copyWith(bottom: 0),
                child: Text(
                  'Title: ' + widget.title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: Text(
                'Description: ' + widget.desc,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: Text(
                'Conducted By: ' + widget.by,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: Text(
                'Date and Time: ' + widget.datetime,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: Text(
                'Topics to be covered: ' + widget.topics,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ButtonBar(children: [
              RaisedButton(child: Text('Interested!'), onPressed: () {}),
              RaisedButton(child: Text('Join Now!'), onPressed: () {}),
            ])
          ],
        ),
      ),
    );
  }
}
