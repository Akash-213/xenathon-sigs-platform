import 'package:flutter/material.dart';

//packages
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

//providers
import 'package:provider/provider.dart';
import 'package:sig_platform/providers/google_auth_provider.dart';
import 'package:sig_platform/widgets/app_drawer.dart';

// tabs
import 'tabs/conductSig_tab.dart';
import 'tabs/schedule_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/profile_tab.dart';

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
    _tabNames = ['Profile', 'Conduct SIG', 'Explore SIG', 'Schedule'];
    _tabs = [
      ProfileTab(),
      ConductSigTab(),
      ExploreTab(),
      ScheduleTab(),
    ];
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
            icon: Icon(Icons.logout),
            onPressed: () async {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .googleLogout();
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
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
            title: Text('Profile'),
            icon: Icon(Icons.person),
            textAlign: TextAlign.center,
            activeColor: Colors.purple[400]!,
            inactiveColor: Colors.black54,
          ),
          BottomNavyBarItem(
            title: Text('Conduct SIG'),
            icon: Icon(Icons.create_new_folder),
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
            title: Text('Schedule'),
            icon: Icon(Icons.calendar_today),
            textAlign: TextAlign.center,
            activeColor: Colors.purple[400]!,
            inactiveColor: Colors.black54,
          ),
        ],
      ),
    );
  }
}
