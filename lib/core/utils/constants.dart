import 'package:flutter/material.dart';

class Constants {
  static EdgeInsets get horizontalPadding =>
      const EdgeInsets.symmetric(horizontal: 16);
}

enum Status { initial, loading, success, error }
