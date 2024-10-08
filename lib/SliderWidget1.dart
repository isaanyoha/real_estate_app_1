import 'package:flutter/material.dart';

class SliderWidget1 extends StatefulWidget {
  final int? typeId;
  final AnimationController? animationController;

  SliderWidget1({
    Key? key,
    this.typeId,
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
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late AnimationController _controller5;

  late Animation<double> _text1Animation1;
  int typeId = 0;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Simulate a delay before starting the fade-in effect
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

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
      Future.delayed(Duration(milliseconds: 4500), () {
        _controller1.forward();
      });

      Future.delayed(Duration(milliseconds: 4000), () {
        _controller2.forward();
      });

      Future.delayed(Duration(milliseconds: 4500), () {
        _controller3.forward();
      });

      Future.delayed(Duration(milliseconds: 4000), () {
        _controller4.forward();
      });

      Future.delayed(Duration(milliseconds: 5000), () {
        _controller5.forward();
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
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width - 10 - 20;

    typeId = widget.typeId ?? 1; // Set default typeId to 1 if null

    if (typeId != 3) {
      screenWidth = screenWidth / 2.1;
    }

    String text1 = "";

    if (typeId == 1) {
      text1 = "Trefoleva St., 43";
    }else if (typeId == 2) {
      text1 = "Gubina St., 11";
    }else if (typeId == 3) {
      text1 = "Gladkova St., 25";
    }else if (typeId == 4) {
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
                width: _stretchAnimation.value, // Animate the container's width
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(20), // Adjust for roundness
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
                            child: Icon(
                              Icons.arrow_circle_right,
                              color: Colors.brown[300],
                              size: 50,
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
                child: Align(alignment: typeId == 3 ? Alignment.center : Alignment.centerLeft , child: Padding(padding: EdgeInsets.only(left: typeId == 3 ? 0: 5), child:

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
