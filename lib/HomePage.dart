import "package:flutter/material.dart";
import "package:real_estate_app_1/CounterWidget1.dart";
import "package:real_estate_app_1/GalleryContentWidget1.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController4;
  late AnimationController _animationController5;
  
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<Offset> _animation4;
  late Animation<Offset> _animation6;

  double _opacity1 = 0.0;
  double _opacity2 = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController1 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animationController2 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animationController4 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animationController5 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _animationController1,
        curve: Curves.easeIn,
      ),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController1,
        curve: Curves.easeOut,
      ),
    );

    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController4,
        curve: Curves.easeOut,
      ),
    );

    // Simulate a delay before starting the fade-in effect
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _opacity1 = 1.0;
        });
      }
    });

    // Simulate a delay before starting the fade-in effect
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _opacity2 = 1.0;
        });
      }
    });

    _animation4 = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start from below
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _animationController2,
      curve: Curves.easeInOut,
    ));

    _animation6 = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start from below
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _animationController5,
      curve: Curves.easeInOut,
    ));

    if (mounted) {
      _animationController1.forward();
    }

    // Start the animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            _animationController2.forward();
          }
        });

        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted) {
            _animationController4.forward();
          }
        });

        Future.delayed(const Duration(milliseconds: 3500), () {
          if (mounted) {
            _animationController5.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController4.dispose();
    _animationController5.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.orangeAccent], // Add your two colors here
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
        child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: SingleChildScrollView(child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedBuilder(
              animation: _animation1,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animation1.value, 0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10), // Adjust the value for more or less roundness
                    ),
                    child:
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: _opacity1),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, opacity, child) {
                        return Opacity(
                          opacity: opacity,
                          child: Row(children: [
                            Icon(Icons.location_on_rounded, color: Colors.brown[300], size: 15), const SizedBox(width: 2), Text("Saint Petersburg", style: TextStyle(fontSize: 13, color: Colors.brown[200], fontWeight: FontWeight.w900), textAlign: TextAlign.left)
                          ]),
                        );
                      },
                    )
                  ),
                );
              },
            ), // Space between the widgets
            AnimatedBuilder(
              animation: _animation2,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation2.value,
                  child: CircleAvatar(
                  child: ClipOval(
                  child: Image.asset(
                    "assets/images/profile_1.jpeg", // Update with your asset image path
                    fit: BoxFit.cover, // Ensures the image covers the entire CircleAvatar
                    width: 60, // Adjust the width as needed
                    height: 60, // Adjust the height as needed
                  ),
                )));
              },
            )
          ],
        ),
        Padding(padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
            children:[
              Row(children:[
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: _opacity2),
            duration: const Duration(milliseconds: 300),
            builder: (context, opacity, child) {
              return Opacity(
                opacity: opacity,
                child: Text("Hi, Marina", style: TextStyle(fontSize: 30, color: Colors.brown[200])),
              );
            },
          ),
        ]),
              Row(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRect( // Clip the widget to limit its visibility
                        child: SizedBox(
                            height: 45, // Set the height of the visible area (acts like a baseline)
                            child: Align(
                                alignment: Alignment.bottomCenter, // Start at the bottom
                                child: SlideTransition(
                        position: _animation4,
                        child: FadeTransition(
                          opacity: _animationController2.drive(CurveTween(curve: Curves.easeIn)),
                          child: const Text(
                            "let's select your",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      )))),
                      ClipRect( // Clip the widget to limit its visibility
                        child: SizedBox(
                            height: 45, // Set the height of the visible area (acts like a baseline)
                            child: Align(
                                alignment: Alignment.bottomCenter, // Start at the bottom
                                child: SlideTransition(
                        position: _animation4,
                        child: FadeTransition(
                          opacity: _animationController2.drive(CurveTween(curve: Curves.easeIn)),
                          child: const Text(
                            "perfect place",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ))))
                    ],
                ),
              ])
            ])),
              Row(
                children: [
                  // Left: Circle
                  Expanded(
                    child: Row(
                      children: [
                        // Left: Circle
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _animation3,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _animation3.value,
                                child: AspectRatio(
                                  aspectRatio: 1, // Aspect ratio of 1:1 to ensure a square or circle
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.orangeAccent,
                                      shape: BoxShape.circle, // Makes the container a circle
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center, // Center aligns all children
                                      children: [
                                        // Positioned for "BUY" at the top center
                                        const Positioned(
                                          top: 20, // Position at the top
                                          child: Text(
                                            "BUY",
                                            style: TextStyle(fontSize: 15, color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        // Center the "1024" text
                                        /**
                                        Text(
                                          "1024",
                                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),
                                          textAlign: TextAlign.center,
                                        )**/
                                        CounterWidget1(typeId: 1)
                                      ,
                                        // Positioned for "offers" below "1024"
                                        Positioned(
                                          bottom: 40, // Position at the bottom
                                          child: Text(
                                            "offers",
                                            style: TextStyle(fontSize: 15, color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ]
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Right: Rounded-corner square
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _animation3,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _animation3.value,
                                child: AspectRatio(
                                  aspectRatio: 1, // Aspect ratio of 1:1 to ensure a square
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.brown[50],
                                      borderRadius: BorderRadius.circular(15), // Rounded corners for square
                                    ),
                                      child:
                                        Stack(
                                        alignment: Alignment.center, // Center aligns all children
                                        children: [
                                          // Positioned for "BUY" at the top center
                                          Positioned(
                                            top: 20, // Position at the top
                                            child: Text(
                                              "RENT",
                                              style: TextStyle(fontSize: 15, color: Colors.brown[300]),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          // Center the "1024" text
                                    /**
                                          Text(
                                            "2212",
                                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.brown[300]),
                                            textAlign: TextAlign.center,
                                          )**/
                                      CounterWidget1(typeId: 2)
                                      ,
                                          // Positioned for "offers" below "1024"
                                          Positioned(
                                            bottom: 40, // Position at the bottom
                                            child: Text(
                                              "offers",
                                              style: TextStyle(fontSize: 15, color: Colors.brown[300]),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                        //)
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ])
            ]))),
              SlideTransition(
                  position: _animation6,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                  borderRadius: BorderRadius.circular(20), // Apply rounded corners
                ),
                child: const Column(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: GalleryContentWidget1(id1: 1),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: GalleryContentWidget1(id1: 2),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GalleryContentWidget1(id1: 3),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GalleryContentWidget1(id1: 4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ])
      )),
    );
  }
}
