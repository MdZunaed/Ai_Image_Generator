import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_gen/controller/image_gen_controller.dart';
import 'package:mind_gen/utility/constant.dart';

import 'screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindGen',
      initialBinding: ControllerBinders(),
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepOrange,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange, backgroundColor: kWhite),
        appBarTheme: const AppBarTheme(color: Colors.deepOrange, elevation: 0),
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.deepOrange))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kOrange,
                foregroundColor: kWhite,
                padding: const EdgeInsets.all(14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 16))),
      ),
      home: const HomePage(),
    );
  }
}

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(ImageGeneratorController());
  }
}
