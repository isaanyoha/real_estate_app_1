import 'package:flutter/material.dart';

class BubbleWidget1 extends StatefulWidget {
  final int? id1;
  final AnimationController? animationController;
  final bool? isIcon;

  BubbleWidget1({
    Key? key,
    this.id1,
    this.animationController,
    this.isIcon,
  }) : super(key: key);

  @override
  _BubbleWidget1State createState() => _BubbleWidget1State();
}

class _BubbleWidget1State extends State<BubbleWidget1> {
  int id1 = 0;
  bool isIcon = false; // Flag to determine whether to show an icon
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    id1 = widget.id1 ?? 1; // Set default id1 to 1 if null
    isIcon = widget.isIcon ?? false; // Initialize isIcon

    // Simulate a delay before starting the fade-in effect
    Future.delayed(Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String text1 = "";

    id1 = widget.id1 ?? 1;
    isIcon = widget.isIcon ?? false;

    if (id1 == 1) {
      text1 = "10.3";
    } else if (id1 == 2) {
      text1 = "12.3";
    } else if (id1 == 3) {
      text1 = "30.3";
    } else if (id1 == 4) {
      text1 = "14.3";
    } else if (id1 == 5) {
      text1 = "19.3";
    } else if (id1 == 6) {
      text1 = "12.3";
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        alignment: Alignment.center, // Center align children within the Stack
        children: [
          // Animated container to manage width change
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Animation duration
            width: isIcon ? 40 : 60, // Adjust the width based on isIcon
            height: 40, // Fixed height for the chat bubble
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), // Rounded top-left
                topRight: Radius.circular(15), // Rounded top-right
                bottomRight: Radius.circular(15), // Rounded bottom-right
                bottomLeft: Radius.zero, // No radius for bottom-left
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10), // Adjust bottom padding if necessary
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: _opacity),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, opacity, child) {
                    return Opacity(
                      opacity: opacity,
                      child: isIcon
                          ? Icon(Icons.house, color: Colors.white, size: 20) // Show icon if isIcon is true
                          : Text(
                        text1 + " P",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                      ), // Show text if isIcon is false
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
