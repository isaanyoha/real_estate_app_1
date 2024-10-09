import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "HomePage.dart";
import "SearchPage.dart";

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
      title: "Flutter Demo",
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

  // List of pages to display
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
  ];

  // Method to handle index change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
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
                          child: Icon(
                            CupertinoIcons.search,
                            color: Colors.orange[50],
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
                          child: Icon(
                            Icons.chat,
                            color: Colors.orange[50],
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
                          child: Icon(
                            Icons.home,
                            color: Colors.orange[50],
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
                          child: Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.orange[50],
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
                          child: Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.orange[50],
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
