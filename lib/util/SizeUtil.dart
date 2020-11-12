import 'package:flutter/material.dart';
import 'dart:math';

class SizeKeyConst {
  static const DEVICE_KEY = "device_size";
}

class SizeUtil {
  static Map<String, SizeUtil> _keyValues = Map();

  static initDesignSize() {
  }

  static SizeUtil getInstance({key = SizeKeyConst.DEVICE_KEY}) {
    if (_keyValues.containsKey(key)) {
      return _keyValues[key];
    } else {
      _keyValues[key] = SizeUtil();
      return _keyValues[key];
    }
  }

  Size _designSize;

  set designSize(Size size) {
    _designSize = size;
  }

  Size _logicalSize;

  get width => _logicalSize.width;

  get height => _logicalSize.height;

  set logicSize(Size size) => _logicalSize = size;

  double getAxisX(double w) {
    return (w * width) / _designSize.width;
  }

  double getAxisY(double h) {
    return (h * height) / _designSize.height;
  }

  double getAxisBoth(double s) {
    return s * sqrt((width * width + height * height) /
            (_designSize.width * _designSize.width +
                _designSize.height * _designSize.height));
  }
}