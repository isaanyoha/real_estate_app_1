import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late Animation<double> _rectangleAnimation;
  late Animation<double> _roundedScaleAnimation1;
  late Animation<double> _roundedScaleAnimation2;

  double _opacity = 0.0;
  late Animation<Offset> _slideAnimation1;
  late Animation<Offset> _slideAnimation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _controller2 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _controller3 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _controller4 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _rectangleAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: Curves.easeIn,
      ),
    );

    _roundedScaleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: Curves.easeOut,
      ),
    );

    _roundedScaleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: Curves.easeOut,
      ),
    );

    // Simulate a delay before starting the fade-in effect
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    _slideAnimation1 = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start from below
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    ));

    _slideAnimation2 = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start from below
      end: Offset.zero, // End at its original position
    ).animate(CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeInOut,
    ));

    // Start the animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller1.forward();
      _controller2.forward();

      Future.delayed(Duration(milliseconds: 500), () {
        _controller3.forward();
      });

      Future.delayed(Duration(milliseconds: 1000), () {
        _controller4.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.orangeAccent], // Add your two colors here
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
        child: Stack(
            children: [
              Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedBuilder(
              animation: _rectangleAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_rectangleAnimation.value, 0),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10), // Adjust the value for more or less roundness
                    ),
                    child:
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: _opacity),
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
              animation: _roundedScaleAnimation1,
              builder: (context, child) {
                return Transform.scale(
                  scale: _roundedScaleAnimation1.value,
                  child: CircleAvatar(
                  child: ClipOval(
                  child: Icon(Icons.face, size: 30, color: Colors.brown,),
                )));
              },
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
            children:[
              Row(children:[
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: _opacity),
            duration: Duration(milliseconds: 500),
            builder: (context, opacity, child) {
              return Opacity(
                opacity: opacity,
                child: Text("Hi, Marina", style: TextStyle(fontSize: 30, color: Colors.brown[200])),
              );
            },
          ),
        ]),
              Row(children:[
                Column(
                    mainAxisAlignment: MainAxisAlignment
                        .start,
                    crossAxisAlignment: CrossAxisAlignment
                        .start,
                    children:[
                SlideTransition(
                    position: _slideAnimation1,
                    child: Text("let's select your",
                      style: TextStyle(fontSize: 35),
                    ),
                ),
                  SlideTransition(
                    position: _slideAnimation2,
                    child: Text("perfect place",
                      style: TextStyle(fontSize: 35),
                    ),
                  )
              ])
            ])])),
              Row(
                children: [
                  // Left: Circle
                  Expanded(
                    child: Row(
                      children: [
                        // Left: Circle
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _roundedScaleAnimation2,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _roundedScaleAnimation2.value,
                                child: AspectRatio(
                                  aspectRatio: 1, // Aspect ratio of 1:1 to ensure a square or circle
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      shape: BoxShape.circle, // Makes the container a circle
                                    ),
                                    child: const Stack(
                                      alignment: Alignment.center, // Center aligns all children
                                      children: [
                                        // Positioned for "BUY" at the top center
                                        Positioned(
                                          top: 20, // Position at the top
                                          child: Text(
                                            "BUY",
                                            style: TextStyle(fontSize: 15, color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        // Center the "1024" text
                                        Text(
                                          "1024",
                                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
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
                        SizedBox(width: 10),
                        // Right: Rounded-corner square
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _roundedScaleAnimation2,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _roundedScaleAnimation2.value,
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
                                          Text(
                                            "2212",
                                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.brown[300]),
                                            textAlign: TextAlign.center,
                                          ),
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
            ]),
              Column(
                  children: [
            ])
            ])
      )),
    );
  }
}
