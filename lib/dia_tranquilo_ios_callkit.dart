import 'package:flutter/services.dart';

class DiaTranquiloIosCallkit {
  DiaTranquiloIosCallkit._();

  static const MethodChannel _channel = MethodChannel(
    'com.khrstian.diatranquilo.ios/callkit',
  );

  static Future<String> isCallDirectoryEnabled() async {
    final String? status =
        await _channel.invokeMethod<String>('isCallDirectoryEnabled');

    return status ?? 'unknown';
  }

  static Future<bool> openCallDirectorySettings() async {
    final bool? success =
        await _channel.invokeMethod<bool>('openCallDirectorySettings');

    return success ?? false;
  }

  static Future<bool> reloadCallDirectoryExtension() async {
    final bool? success =
        await _channel.invokeMethod<bool>('reloadCallDirectoryExtension');

    return success ?? false;
  }
}
