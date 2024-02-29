import 'package:e_tracker/pages/e_category.dart';
import 'package:e_tracker/pages/expenses.dart';
import 'package:e_tracker/pages/view_expenses.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _mainContentIndex = 0;
  int _bottomNavBarIndex = 0;
  bool _isBottomNavBarSelected = false;

  static final List<Widget> _mainContentOptions = <Widget>[
    const Text(
      'Dashboard',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const ExpensesCategory(),
    const Expenses(),
    const ExpensesView(),
  ];

  static final List<Widget> _bottomNavBarOptions = <Widget>[
    const Text(
      'Home',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Account',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Profile',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Budget Tracking',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _mainContentIndex = index;
      _isBottomNavBarSelected =
          false; // Reset the flag when drawer item is tapped
    });
  }

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _bottomNavBarIndex = index;
      _isBottomNavBarSelected =
          true; // Set the flag when bottom nav item is tapped
      _mainContentIndex =
          0; // Reset main content index when bottom nav item is tapped
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Your Expenses in one Place'),
        backgroundColor: Colors.grey,
      ),
      body: _isBottomNavBarSelected
          ? _bottomNavBarOptions[_bottomNavBarIndex]
          : _mainContentOptions[_mainContentIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 149, 146, 153),
              ),
              accountName: Text(
                widget.data,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: const Text(
                "abcdeh@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: const FlutterLogo(),
            ),
            ListTile(
              title: const Text('DashBoard'),
              leading: const Icon(Icons.dashboard),
              onTap: () {
                _onDrawerItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add Expenses Category'),
              leading: const Icon(Icons.category),
              onTap: () {
                _onDrawerItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add Expenses'),
              leading: const Icon(Icons.add_circle),
              onTap: () {
                _onDrawerItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('View Expense'),
              leading: const Icon(Icons.view_list),
              onTap: () {
                _onDrawerItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey, // Set background color
        unselectedItemColor: Colors.black, // Set color for unselected items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Budget Tracking',
          ),
        ],
        currentIndex: _bottomNavBarIndex,
        selectedItemColor: _isBottomNavBarSelected
            ? Colors.blue
            : Colors.black, // Conditional color for selected item
        onTap: _onBottomNavBarItemTapped,
      ),
    );
  }
}
