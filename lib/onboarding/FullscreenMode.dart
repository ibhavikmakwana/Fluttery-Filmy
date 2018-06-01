import 'package:flutter/services.dart';

class FullscreenMode {
  static const MethodChannel _channel = const MethodChannel('fullscreen_mode');

  static void setFullscreen() {
    _channel.invokeMethod('setFullscreen');
  }

  static void setNormal() {
    _channel.invokeMethod('setNormal');
  }
}
