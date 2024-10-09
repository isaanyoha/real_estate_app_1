import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'SearchPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Real Estate App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
        fontFamily: "CustomFontWithFallback",
      ),
      home: const MainPage(), // Set MainPage as home
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _animationController1;
  late Animation<Offset> _animation1;

  int _selectedIndex = 0; // To track the selected index

  // List of pages to display, each wrapped with a KeyedSubtree for reload functionality
  final List<Widget> _pages = [
    KeyedSubtree(key: UniqueKey(), child: HomePage()),
    KeyedSubtree(key: UniqueKey(), child: SearchPage()),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // If the current page is tapped again, reload the page
      setState(() {
        _pages[_selectedIndex] = KeyedSubtree(
          key: UniqueKey(),
          child: _buildPage(_selectedIndex), // Rebuild the current page
        );
      });
    } else {
      setState(() {
        _selectedIndex = index; // Update the selected index
      });
    }
  }

// Helper function to build the pages
  Widget _buildPage(int index) {
    if (index == 0) {
      return HomePage();
    } else {
      return SearchPage();
    }
  }


  @override
  void initState() {
    super.initState();

    _animationController1 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation1 = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start from below
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _animationController1,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 7000), () {
        _animationController1.forward();
      });
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
            child: SlideTransition(
              position: _animation1,
              child: FadeTransition(
                opacity: _animationController1.drive(CurveTween(curve: Curves.easeIn)),
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
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedIndex == 1 ? Colors.orangeAccent : Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(15.0), // Padding for the circle
                          child: const Icon(
                            CupertinoIcons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(15.0), // Padding for the circle
                          child: const Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onItemTapped(0), // Navigate to Home
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedIndex == 0 ? Colors.orangeAccent : Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(15.0), // Padding for the circle
                          child: const Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(15.0), // Padding for the circle
                          child: const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {}, // Navigate to Search
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(15.0), // Padding for the circle
                          child: const Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
