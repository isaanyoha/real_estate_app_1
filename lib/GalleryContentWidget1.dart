import 'package:flutter/material.dart';
import 'package:real_estate_app_1/SliderWidget1.dart';

class GalleryContentWidget1 extends StatefulWidget {
  final int? typeId;
  final AnimationController? animationController;

  GalleryContentWidget1({
    Key? key,
    this.typeId,
    this.animationController,
  }) : super(key: key);

  @override
  _GalleryContentWidget1State createState() => _GalleryContentWidget1State();
}

class _GalleryContentWidget1State extends State<GalleryContentWidget1> {
  int typeId = 0;

  @override
  void initState() {
    super.initState();
    typeId = widget.typeId ?? 1; // Set default typeId to 1 if null
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Load the image based on the typeId
    Widget imageWidget = Container();

    final BorderRadius commonBorderRadius = BorderRadius.circular(16); // Define rounded corners

    if (typeId == 1) {
      // Square container for typeId = 1
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: commonBorderRadius, // Apply rounded corners
          image: DecorationImage(
            image: AssetImage('assets/images/s_1.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (typeId == 2) {
      // Vertical rectangle container for typeId = 2
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: commonBorderRadius, // Apply rounded corners
          image: DecorationImage(
            image: AssetImage('assets/images/r_v_1.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (typeId == 3) {
      // Horizontal rectangle container for typeId = 3
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: commonBorderRadius, // Apply rounded corners
          image: DecorationImage(
            image: AssetImage('assets/images/r_h_1.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          Center(child: imageWidget), // Center the image in the Stack

          Positioned(
            bottom: 0, // Position the slider at the bottom
            left: 0, // Align to the left edge
            right: 0, // Align to the right edge
            child: Padding(padding: EdgeInsets.only(left: 10, bottom: 10),
                child:SliderWidget1(typeId: typeId)), // The Slider widget now stretches to full width
          ),
        ],
      ),
    );
  }
}
