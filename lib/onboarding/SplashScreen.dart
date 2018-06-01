import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
// Demonstrate a simple animation with AnimatedWidget

class AnimatedLogo extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _opacityTween = new Tween<double>(begin: 0.0, end: 1.0);

  static final _sizeTween = new Tween<double>(begin: 100.0, end: 300.0);

  AnimatedLogo({Animation<double> animation}) : super(listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Material(
      child: new Container(
        color: Colors.white,
        child: new Stack(
          alignment: new Alignment(00.00, 00.00),
          children: <Widget>[
            new Opacity(
              opacity: _opacityTween.evaluate(animation),
              child: new Container(
                height: _sizeTween.evaluate(animation),
                width: _sizeTween.evaluate(animation),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlueAccent,
                  border: new Border.all(
                    color: Colors.lightBlueAccent,
                  ),
                ),
                padding: const EdgeInsets.all(32.0),
                child: new Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: new Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  padding: const EdgeInsets.all(32.0),
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 10.0),
              child: new Image(
                image: new AssetImage('assets/launcher.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    animation = new CurvedAnimation(
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
    return new AnimatedLogo(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(new LogoApp());
}
