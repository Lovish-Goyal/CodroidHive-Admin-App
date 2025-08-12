import 'package:flutter/material.dart';
import 'package:admin_app/features/courses/courses_screen.dart';
import 'package:admin_app/features/events/events_screen.dart';
import 'package:admin_app/features/home/home_screen.dart';
import 'package:admin_app/features/jobs/jobs_screen.dart';
import '../shared/custom_drawer.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    JobsScreen(),
    EventsScreen(),
    CoursesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text(
          'Community Admin Panel',
          style: const TextStyle(
              color: Color.fromARGB(255, 10, 29, 86),
              fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 29, 86)),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 38, 68, 156),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline), label: 'Jobs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: 'Courses'),
        ],
      ),
    );
  }
}
