import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation_rotation;
  Animation<double> animation_raduis_in;
  Animation<double> animation_raduis_out;
  final double initialRaduis = 15.0;
  double raduis = 0.0;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1.0, curve: Curves.linear)));
    animation_raduis_in = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));
    animation_raduis_out = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));
    animationController.addListener(() {
      setState(() {
        if (animationController.value >= 0.75 &&
            animationController.value <= 1.0) {
          raduis = animation_raduis_in.value * initialRaduis;
        } else if (animationController.value >= 0.0 &&
            animationController.value <= 0.25) {
          raduis = animation_raduis_out.value * initialRaduis;
        }
      });
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: RotationTransition(
        turns: animation_rotation,
        child: Stack(
          children: <Widget>[
            Dot(
              raduis: 15.0,
              color: Colors.black12,
            ),
            Transform.translate(
              offset: Offset(raduis * cos(pi / 4), raduis * sin(pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.redAccent,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(raduis * cos(2 * pi / 4), raduis * sin(2 * pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.greenAccent,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(raduis * cos(3 * pi / 4), raduis * sin(3 * pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.blueAccent,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(raduis * cos(4 * pi / 4), raduis * sin(4 * pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.purple,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(raduis * cos(5 * pi / 4), raduis * sin(5 * pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.amberAccent,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(raduis * cos(6 * pi / 4), raduis * sin(6 * pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.blue,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(raduis * cos(7 * pi / 4), raduis * sin(7 * pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.orangeAccent,
              ),
            ),
            Transform.translate(
              offset:
                  Offset(raduis * cos(8 * pi / 4), raduis * sin(8 * pi / 4)),
              child: Dot(
                raduis: 5.0,
                color: Colors.lightGreenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double raduis;
  final Color color;

  Dot({this.raduis, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.raduis,
        height: this.raduis,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
