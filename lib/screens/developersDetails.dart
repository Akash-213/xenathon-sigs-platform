import 'package:flutter/material.dart';

import 'developersCard.dart';

class Developers extends StatefulWidget {
  static const routeName = '/Developers';
  const Developers();

  @override
  _DevelopersState createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DEVELOPER SECTION'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CardWidget(
                    name: 'Akash Kulkarni',
                    link: 'https://www.linkedin.com/in/akash213kulkarni/',
                    image: 'assets/developers/Akash.jpeg',
                  ),
                  CardWidget(
                    name: 'Sejal Pekam',
                    link: 'https://www.linkedin.com/in/sejal-pekam/',
                    image: 'assets/developers/Sejal.jpg',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
