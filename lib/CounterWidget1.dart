import "package:flutter/material.dart";

class CounterWidget1 extends StatefulWidget {
  final int? typeId;

  CounterWidget1({
    Key? key,
    this.typeId,
  }) : super(key: key);

  @override
  _CounterWidget1State createState() => _CounterWidget1State();
}

class _CounterWidget1State extends State<CounterWidget1> {
  int typeId = 0;
  String counter1 = "";
  int startValue = 100;
  int endValue = 1034; // Default range for typeId 1

  @override
  void initState() {
    super.initState();
    typeId = widget.typeId ?? 1;
    // Set the counter range based on the typeId
    if (typeId == 2) {
      endValue = 2212; // Set range for typeId 2
    }
    // Set initial counter value immediately
    counter1 = startValue.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;

    late Color? fontColor;

    if (typeId == 1) {
      fontColor = Colors.white;
    } else if (typeId == 2) {
      fontColor = Colors.brown[300];
    }

    textStyle = TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w900,
        color: fontColor
    );

    return StreamBuilder<String>(
      stream: counterStream(context),
      initialData: counter1, // Start with initial value
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Error",
            style: textStyle,
            textAlign: TextAlign.center,
          );
        } else {
          counter1 = snapshot.data ?? startValue.toString();
          return Text(
            counter1,
            style: textStyle,
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Stream<String> counterStream(BuildContext context) async* {
    for (int i = startValue; i <= endValue; i++) {
      yield i.toString();
      await Future.delayed(const Duration(microseconds: 250));
    }
  }
}
