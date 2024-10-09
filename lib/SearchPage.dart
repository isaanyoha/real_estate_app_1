import 'package:flutter/material.dart';
import 'BubbleWidget1.dart'; // Ensure this import matches your file structure

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _roundedScaleAnimation1;
  late AnimationController _listController;
  late Animation<double> _listScaleAnimation;
  late AnimationController _bubbleController; // New animation controller
  bool _showList = false;
  IconData _floatingIcon = Icons.wallet;
  int? _selectedIndex = 1;

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.safety_check_outlined, 'title': 'Cosy areas'},
    {'icon': Icons.wallet, 'title': 'Price'},
    {'icon': Icons.shopping_basket, 'title': 'Infrastructure'},
    {'icon': Icons.layers, 'title': 'Without any Layer'},
  ];

  // List of positions for the BubbleWidgets
  final List<Offset> _bubblePositions = [
    Offset(100, 100),
    Offset(200, 200),
    Offset(300, 100),
    Offset(100, 300),
    Offset(200, 400),
    Offset(300, 300),
  ];

  bool isIcon = false;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _roundedScaleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: Curves.easeOut,
      ),
    );

    _listController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _listScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _listController,
        curve: Curves.easeOut,
      ),
    );

    _bubbleController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller1.forward();
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          _bubbleController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _listController.dispose();
    _bubbleController.dispose(); // Dispose the bubble controller
    super.dispose();
  }

  Future<void> _hideList() async {
    if (_showList) {
      await _listController.reverse();
      setState(() {
        _showList = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _hideList, // Call the hide list function when tapping outside
        child: Stack(
          children: [
            // First child: Google Map view (dummy)
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/google_map_view_1.jpeg"), // Replace with your asset image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Bubble widgets positioned at specified offsets with scale animation
            ..._bubblePositions.map((offset) {
              return Positioned(
                left: offset.dx,
                top: offset.dy,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _bubbleController,
                    curve: Curves.easeOut,
                  ),
                  child: BubbleWidget1(
                    id1: _bubblePositions.indexOf(offset) + 1, // Assign id based on index
                    animationController: _controller1,
                    isIcon: isIcon,
                  ),
                ),
              );
            }).toList(),
            // Search TextField positioned to the left
            Positioned(
              top: 20,
              left: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Saint Petersburg",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            // Settings icon positioned at the top right
            Positioned(
              top: 20,
              right: 20,
              child: AnimatedBuilder(
                animation: _roundedScaleAnimation1,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _roundedScaleAnimation1.value,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.tune_rounded, color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Third child: Floating button at bottom-left
            Positioned(
              bottom: 100,
              left: 20,
              child: Column(
                children: [
                  Stack(children: [
                    AnimatedBuilder(
                      animation: _roundedScaleAnimation1,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _roundedScaleAnimation1.value,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showList = !_showList; // Toggle the list visibility
                                if (_showList) {
                                  _listController.forward(); // Start showing the list with animation
                                } else {
                                  _listController.reverse(); // Start hiding the list with animation
                                }
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Center(child: Icon(_floatingIcon, color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    ),
                  ]),
                  const SizedBox(height: 5),
                  AnimatedBuilder(
                    animation: _roundedScaleAnimation1,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _roundedScaleAnimation1.value,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          child: const Center(
                            child: Icon(Icons.navigation_rounded, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Fourth child: Row with list icon and text at bottom-right
            Positioned(
              bottom: 100,
              right: 20,
              child: AnimatedBuilder(
                animation: _roundedScaleAnimation1,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _roundedScaleAnimation1.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const Row(
                        children: [
                          Icon(Icons.list, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            "List Of Variants",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Conditional rendering of the list items with scaling animation
            if (_showList)
              Positioned(
                bottom: 155,
                left: 20,
                child: SizedBox(
                  width: 200, // Set a width for the list
                  child: AnimatedBuilder(
                    animation: _listScaleAnimation,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..translate(-10 * (1 - _listScaleAnimation.value), -10 * (1 - _listScaleAnimation.value))
                          ..scale(_listScaleAnimation.value),
                        alignment: Alignment.bottomLeft,
                        child: _buildListItems(),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItems() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(20),
      ),
      // Remove height constraint so that the container adapts to content
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Scroll horizontally if needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
          children: _items.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> item = entry.value;
            bool isSelected = _selectedIndex == index;

            return GestureDetector(
              onTap: () async {
                _selectedIndex = index;
                _floatingIcon = item['icon'];
                await _listController.reverse();
                _showList = false;

                isIcon = (_selectedIndex == 3);

                setState(() {});
              },
              child: ListTile(
                leading: Icon(
                  item['icon'],
                  color: isSelected ? Colors.orange : Colors.black45,
                ),
                title: Text(
                  item['title'],
                  style: TextStyle(color: isSelected ? Colors.orange : Colors.black45),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}