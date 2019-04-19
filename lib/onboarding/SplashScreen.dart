import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
// Demonstrate a simple animation with AnimatedWidget

class AnimatedLogo extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.0, end: 1.0);

  static final _sizeTween = Tween<double>(begin: 100.0, end: 300.0);

  AnimatedLogo({Animation<double> animation}) : super(listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment(00.00, 00.00),
          children: <Widget>[
            Opacity(
              opacity: _opacityTween.evaluate(animation),
              child: Container(
                height: _sizeTween.evaluate(animation),
                width: _sizeTween.evaluate(animation),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlueAccent,
                  border: Border.all(
                    color: Colors.lightBlueAccent,
                  ),
                ),
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  padding: const EdgeInsets.all(32.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Image(
                image: AssetImage('assets/launcher.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    );

    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });
  }

  Widget build(BuildContext context) {
    return AnimatedLogo(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(LogoApp());
}
