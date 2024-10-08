import 'package:flutter/material.dart';
import 'package:real_estate_app_1/SliderWidget1.dart';

class GalleryContentWidget1 extends StatefulWidget {
  final int? id1;
  final AnimationController? animationController;

  GalleryContentWidget1({
    Key? key,
    this.id1,
    this.animationController,
  }) : super(key: key);

  @override
  _GalleryContentWidget1State createState() => _GalleryContentWidget1State();
}

class _GalleryContentWidget1State extends State<GalleryContentWidget1> {
  int id1 = 0;

  @override
  void initState() {
    super.initState();
    id1 = widget.id1 ?? 1; // Set default id1 to 1 if null
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Load the image based on the id1
    Widget imageWidget = Container();

    final BorderRadius commonBorderRadius = BorderRadius.circular(16); // Define rounded corners

    if (id1 == 1) {
      // Horizontal rectangle container for id1 = 3
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: commonBorderRadius, // Apply rounded corners
          image: DecorationImage(
            image: AssetImage('assets/images/r_h_1.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      );
    }else if (id1 == 2) {
    // Vertical rectangle container for id1 = 2
    imageWidget = Container(
    decoration: BoxDecoration(
    borderRadius: commonBorderRadius, // Apply rounded corners
    image: DecorationImage(
    image: AssetImage('assets/images/r_v_1.jpeg'), // Replace with your image path
    fit: BoxFit.cover,
    ),
    ),
    );
    }else if (id1 == 3 || id1 == 4) {
      String imageUrl1 = "";

      if (id1 == 3) {
        imageUrl1 = "s_1";
      }else if (id1 == 4) {
        imageUrl1 = "s_2";
      }

      // Square container for id1 = 1
      imageWidget = Container(
        decoration: BoxDecoration(
          borderRadius: commonBorderRadius, // Apply rounded corners
          image: DecorationImage(
            image: AssetImage("assets/images/"+imageUrl1+".jpeg"), // Replace with your image path
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
                child:SliderWidget1(id1: id1)), // The Slider widget now stretches to full width
          ),
        ],
      ),
    );
  }
}
