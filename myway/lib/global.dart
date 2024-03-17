import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:junkee/schedule.dart';
import 'package:timelines/timelines.dart';

class InclinedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primary_color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // Define the path to draw the inclined line and fill the region above it
    Path path = Path();
    path.moveTo(0, size.height * 0.35); // Start from the left corner of the top region
    path.lineTo(size.width, size.height * 0.17); // Draw a line to the right corner, adjusted for inclination
    path.lineTo(size.width, 0); // Draw a line to the top-right corner
    path.lineTo(0, 0); // Draw a line to the top-left corner
    path.close(); // Close the path to form a closed shape

    canvas.drawPath(path, paint); // Draw the path

    // Draw the inclined line
    canvas.drawLine(
      Offset(0, size.height * 0.15), // Start point
      Offset(size.width, size.height * 0.07), // End point, adjusted for inclination
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Color primary_color=Color(0xff0c6377);
String baseurl = "https://ultimate-prime-cattle.ngrok-free.app";
String user_id="1";


const kTileHeight = 20.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class ProcessTimelinePage extends StatefulWidget {
  final int progressIndex; // Add the progressIndex parameter

  ProcessTimelinePage({required this.progressIndex}); // Constructor

  @override
  _ProcessTimelinePageState createState() => _ProcessTimelinePageState();
}

class _ProcessTimelinePageState extends State<ProcessTimelinePage> {
  late int _processIndex; // Change _processIndex to late variable

  @override
  void initState() {
    super.initState();
    // Initialize _processIndex with the passed progressIndex
    _processIndex = widget.progressIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pickup Request',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          connectorTheme: ConnectorThemeData(
            space: 30.0,
            thickness: 5.0,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
              MediaQuery.of(context).size.width / 3,
          contentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                _processes[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getColor(index),
                ),
              ),
            );
          },
          indicatorBuilder: (_, index) {
            var color;
            var child;
            if (index == _processIndex) {
              color = inProgressColor;
              child = Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40.0, // Adjust the height to match the size of the DotIndicator
                  width: 40.0, // Adjust the width to match the size of the DotIndicator
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              );
            } else if (index < _processIndex) {
              color = completeColor;
              child = Icon(
                Icons.check,
                color: Colors.white,
                size: 15.0,
              );
            } else {
              color = todoColor;
              // Add a white container on top of the fifth dot indicator
              if (index == _processes.length - 1) {
                return Container(
                  width: 40.0,
                  height: 40.0,
                  color: Colors.white,
                );
              }
            }

            if (index <= _processIndex) {
              return Container(
                height: 30.0, // Adjust the height of the container
                child: Stack(
                  children: [
                    DotIndicator(
                      //add a condition so that size will be 30  for got with index 0 and 4
                      size: (index == 0 || index == 4) ? 0 : 20.0,
                      color: color,
                      child: child,
                    ),
                  ],
                ),
              );
            } else {
              return Stack(
                children: [
                  OutlinedDotIndicator(
                    borderWidth: 4.0,
                    color: color,
                  ),
                ],
              );
            }
          },
          connectorBuilder: (_, index, type) {
            if ((index == 0 && type == ConnectorType.start) ||
                (index == _processes.length - 1 && type == ConnectorType.end)) {
              // Add a small line before the first node and after the third node
              return SolidLineConnector(
                color: _getColor(index),
              );
            } else if (index > 0) {
              if (index == _processIndex) {
                final prevColor = _getColor(index - 1);
                final color = _getColor(index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [
                    Color.lerp(prevColor, color, 0.5)!,
                    color,
                  ];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)!,
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: _getColor(index),
                );
              }
            } else {
              return null;
            }
          },
          itemCount: _processes.length,
        ),
      ),
    );
  }

  Color _getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }
}

final _processes = [
  '',
  'Select Item',
  'Schedule',
  'Check Out',
  '',
];

class Helpline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "This is the helpline page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}