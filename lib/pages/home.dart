import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:safesync/pages/notifications.dart';
import 'messages.dart';
import 'location.dart';
import 'account_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    _buildDashboard(),
    const MessagesPage(),
    const NotificationsPage(),
    const LocationPage(),
  ];

  static Widget _buildDashboard() {
    return Column(
      children: [
        const SizedBox(height: 50),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const _AppBar(),
              _buildDashboardContainer(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildDashboardContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _buildDashboardItem('Agencies', Icons.shield, Colors.deepOrange),
          _buildDashboardItem('Quick Call', Icons.phone, Colors.green),
          _buildDashboardItem('Information', Icons.book, Colors.purple),
          _buildDashboardItem('Reports', Icons.report, Colors.brown),
          _buildDashboardItem('Community', Icons.people, Colors.blue),
          _buildDashboardItem('More', Icons.more_horiz_outlined, Colors.teal),
        ],
      ),
    );
  }

  static Widget _buildDashboardItem(
      String title, IconData iconData, Color background) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.indigo,
        ),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_fill),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell_fill),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.location_fill),
            label: 'Locations',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.black45,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountDashboard()),
        );
      },
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            title: Text(
              'Welcome Back!',
            ),
            subtitle: Text(
              'Theodore B.',
            ),
            trailing: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.indigo,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
