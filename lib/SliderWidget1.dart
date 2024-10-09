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
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _animation4;
  late Animation<double> _animation5;

  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late AnimationController _controller5;

  int id1 = 0;

  @override
  void initState() {
    super.initState();
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _controller4 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _controller5 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Animation for stretching (width of the screen)
    _animation4 = Tween<double>(begin: 50, end: 500).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: Curves.easeOut,
      ),
    );

    // Initialize the sliding animation (moving the icon)
    _animation3 = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
      int delay = 0;
      if (id1 == 1) {
        delay = 0;
      } else if (id1 == 3) {
        delay = 100;
      } else if (id1 == 2 || id1 == 4) {
        delay = 500;
      }

      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted) {
        Future.delayed(const Duration(milliseconds: 5000), () {
          if (mounted) {
            _controller2.forward();
          }
        });

        Future.delayed(const Duration(milliseconds: 5500), () {
          if (mounted) {
            _controller3.forward();
          }
        });

        Future.delayed(const Duration(milliseconds: 5000), () {
          if (mounted) {
            _controller4.forward();
          }
        });

        Future.delayed(const Duration(milliseconds: 6000), () {
          if (mounted) {
            _controller5.forward();
          }
        });
      }
      });
    }
    });

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeOut,
      ),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: Curves.easeOut,
      ),
    );

    // Create a combined animation that listens to both animations
    _animation5 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller5, // You can change this parent if needed
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();

    super.dispose();
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
    _animation4 = Tween<double>(begin: 50, end: screenWidth).animate(
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
          animation: Listenable.merge([_animation2, _animation4]),
          builder: (context, child) {
            return Transform.scale(
              scale: _animation2.value, // Apply the scale animation to the container
              child: Container(
                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 4, right: 4),
                width: _animation4.value, // Animate the container's width
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
                      offset: Offset(_animation3.value * (1 / 100), 0), // Slide the icon to the right
                      child: AnimatedBuilder(
                        animation: _animation1,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _animation1.value,
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
        offset: const Offset(2.0, 2.0), // Direction of the shadow
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
    animation: _animation5,
    builder: (context, child) {
    return Transform.scale(
    scale: _animation5.value,
    child: Text(text1, textAlign: TextAlign.center));
    },
    )
                ))))
      ],
    );
  }
}
