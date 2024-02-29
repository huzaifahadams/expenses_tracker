import 'package:flutter/material.dart';

import 'pages/e_category.dart';
import 'pages/expenses.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.data});

  final String data;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Dashboard',
      style: optionStyle,
    ),
    const ExpensesCategory(),
    const Expenses(),
    Text(
      'Index 3: last',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Your Expenses in one Place'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 149, 146, 153)),
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
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add Expenses Category'),
              leading: const Icon(Icons.category),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add Expenses'),
              leading: const Icon(Icons.add_circle),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('View Expense'),
              leading: const Icon(Icons.view_list),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
