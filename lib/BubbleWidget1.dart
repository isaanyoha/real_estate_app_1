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
  double _opacity = 1.0;
  bool _showNewContent = false;

  @override
  void initState() {
    super.initState();
    isIcon = widget.isIcon ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 600), () {
        if (mounted) {
          _handleOpacityChange();
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant BubbleWidget1 oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if isIcon has changed
    if (oldWidget.isIcon != widget.isIcon) {
      _handleOpacityChange();
    }
  }

  void _handleOpacityChange() {
    // Step 1: Fade out the old content
    setState(() {
      _opacity = 0.0;
    });

    // Step 2: Wait for the fade out to complete, then switch content and fade in
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isIcon = widget.isIcon ?? false;
          _showNewContent = true; // Show new content after fade-out
          _opacity = 1.0; // Fade in the new content
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String text1 = "";

    id1 = widget.id1 ?? 1;

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
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isIcon ? 40 : 60,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.zero,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: _opacity),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, opacity, child) {
                    return Opacity(
                      opacity: opacity,
                      child: _showNewContent
                          ? (isIcon
                          ? Icon(Icons.grid_on_sharp, color: Colors.white, size: 20)
                          : Text(
                        text1 + " P",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                      ))
                          : null, // Show nothing during fade out
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
