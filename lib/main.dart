import 'package:flutter/material.dart';
import 'HomePage.dart'; // Ensure you have a HomePage.dart file
import 'SearchPage.dart'; // Ensure you have a SearchPage.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
        fontFamily: 'CustomFontWithFallback',
      ),
      home: MainPage(), // Set MainPage as home
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // To track the selected index

  // List of pages to display
  final List<Widget> _pages = [
    HomePage(), // HomePage widget
    SearchPage(), // SearchPage widget
  ];

  // Method to handle index change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex], // Display the selected page
          Positioned(
            bottom: 20, // Distance from bottom
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _onItemTapped(1), // Navigate to Search
                    child: Expanded(child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedIndex == 1 ? Colors.orangeAccent : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(15.0), // Padding for the circle
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Expanded(child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(15.0), // Padding for the circle
                      child: Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  GestureDetector(
                    onTap: () => _onItemTapped(0), // Navigate to Home
                    child: Expanded(child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedIndex == 0 ? Colors.orangeAccent : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(15.0), // Padding for the circle
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Expanded(child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(15.0), // Padding for the circle
                      child: Icon(
                        Icons.heart_broken,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  GestureDetector(
                    onTap: () {

                    }, // Navigate to Search
                    child: Expanded(child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(15.0), // Padding for the circle
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
