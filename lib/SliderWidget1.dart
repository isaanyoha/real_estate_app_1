import 'package:flutter/material.dart';

class SliderWidget1 extends StatefulWidget {
  final int? id1;
  final AnimationController? animationController;

  SliderWidget1({
    Key? key,
    this.id1,
    this.animationController,
  }) : super(key: key);

  @override
  _SliderWidget1State createState() => _SliderWidget1State();
}

class _SliderWidget1State extends State<SliderWidget1>
    with TickerProviderStateMixin {
  late Animation<double> _roundedScaleAnimation1;
  late Animation<double> _roundedScaleAnimation2;
  late Animation<double> _slideAnimation; // Animation for sliding effect
  late Animation<double> _stretchAnimation; // Animation for stretching
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late AnimationController _controller5;

  late Animation<double> _text1Animation1;
  int id1 = 0;

  @override
  void initState() {
    super.initState();
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _controller3 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _controller4 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _controller5 = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    // Animation for stretching (width of the screen)
    _stretchAnimation = Tween<double>(begin: 50, end: 500).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: Curves.easeOut,
      ),
    );

    // Initialize the sliding animation (moving the icon)
    _slideAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {

      int delay = 0;
      if(id1 == 1){
        delay = 0;
      }else if(id1 == 3){
        delay = 100;
      }else if(id1 == 2 || id1 == 4){
        delay = 500;
      }

      Future.delayed(Duration(milliseconds: delay), () {
        Future.delayed(Duration(milliseconds: 5000), () {
        _controller2.forward();
      });

      Future.delayed(Duration(milliseconds: 5500), () {
        _controller3.forward();
      });

      Future.delayed(Duration(milliseconds: 5000), () {
        _controller4.forward();
      });

      Future.delayed(Duration(milliseconds: 6000), () {
        _controller5.forward();
      });
    });
    });

    _roundedScaleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeOut,
      ),
    );

    _roundedScaleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: Curves.easeOut,
      ),
    );

    // Create a combined animation that listens to both animations
    _text1Animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller5, // You can change this parent if needed
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width - 10 - 20;

    id1 = widget.id1 ?? 1;

    if (id1 != 1) {
      screenWidth = screenWidth / 2.1;
    }

    String text1 = "";

    if (id1 == 1) {
      text1 = "Gladkova St., 25";
    }else if (id1 == 2) {
      text1 = "Gubina St., 11";
    }else if (id1 == 3) {
      text1 = "Trefoleva St., 43";
    }else if (id1 == 4) {
      text1 = "Sedova St., 22";
    }

    // Update the end value of the stretch animation to match the screen width
    _stretchAnimation = Tween<double>(begin: 50, end: screenWidth).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: Curves.easeOut,
      ),
    );

    return Stack(
      //mainAxisSize: MainAxisSize.max,
      children: [
        // Use an AnimatedBuilder to animate the width and icon position
        AnimatedBuilder(
          animation: Listenable.merge([_roundedScaleAnimation2, _stretchAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _roundedScaleAnimation2.value, // Apply the scale animation to the container
              child: Container(
                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 4, right: 4),
                width: _stretchAnimation.value, // Animate the container's width
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25), // Adjust for roundness
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 5.0),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Align the icon to the right
                  children: [
                    Transform.translate(
                      offset: Offset(_slideAnimation.value * (1 / 100), 0), // Slide the icon to the right
                      child: AnimatedBuilder(
                        animation: _roundedScaleAnimation1,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _roundedScaleAnimation1.value,
                            child: Container(
                              width: 40, // Set width and height to ensure it's a circle
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange[50],
                                boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4), // Shadow color
        blurRadius: 10.0, // Spread of the shadow
        offset: Offset(2.0, 2.0), // Direction of the shadow
      ),
    ],
                              ),
                              child: Center(  // Center the icon within the circle
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.brown[300],
                                  size: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
                child: Align(alignment: id1 == 1 ? Alignment.center : Alignment.centerLeft , child: Padding(padding: EdgeInsets.only(left: id1 == 1 ? 0: 5), child:

    AnimatedBuilder(
    animation: _text1Animation1,
    builder: (context, child) {
    return Transform.scale(
    scale: _text1Animation1.value,
    child: Text(text1, textAlign: TextAlign.center));
    },
    )
                ))))
      ],
    );
  }
}
