import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//packages
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

//providers
import 'package:provider/provider.dart';
import 'package:sig_platform/providers/google_auth_provider.dart';
import 'package:sig_platform/widgets/loading_widget.dart';

// tabs
import './tabs/tab1.dart';
import './tabs/tab2.dart';
import './tabs/tab3.dart';

//widgets
class BottomBarScreen extends StatefulWidget {
  static const routeName = '/bottomBar';
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late int _selectedIndex;

  late List<String> _tabNames;
  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabNames = ['Schedule', 'Explore SIG', 'Conduct SIG'];
    _tabs = [Tab1(), Tab2(), Tab3()];
    _selectedIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(_tabNames[_selectedIndex]),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => (),
              //   ),
              // );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .googleLogout();
            },
          ),
        ],
      ),
      // drawer: AppDrawer(),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (clickedIndex) async {
          setState(() {
            _selectedIndex = clickedIndex;
          });
        },
        animationDuration: Duration(milliseconds: 500),
        curve: Curves.easeInCirc,
        items: [
          BottomNavyBarItem(
            title: Text('Schedule'),
            icon: Icon(Icons.schedule),
            textAlign: TextAlign.center,
            activeColor: Colors.purple[400]!,
            inactiveColor: Colors.black54,
          ),
          BottomNavyBarItem(
            title: Text('Explore'),
            textAlign: TextAlign.center,
            icon: Icon(Icons.explore),
            activeColor: Colors.purple[400]!,
            inactiveColor: Colors.black54,
          ),
          BottomNavyBarItem(
            title: Text('Conduct SIG'),
            icon: Icon(Icons.add_box_outlined),
            textAlign: TextAlign.center,
            activeColor: Colors.purple[400]!,
            inactiveColor: Colors.black54,
          ),
        ],
      ),
    );
  }
}
