
import 'package:api/main_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'module13/class2.dart';



//All Package imported


void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        home:API_calling( ),
      ), // runApp এর ভিতরে DevicePreview
    ),
  );
}