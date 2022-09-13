import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));

  doWhenWindowReady(() {
    appWindow.minSize = const Size(400, 500);
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Typing',
      theme: ThemeData(
        fontFamily: 'RobotoMono',
        scaffoldBackgroundColor: const Color(0xff282a36),
        primaryColor: const Color(0xff282a36),
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff282a36),
            minimumSize: const Size(20, 56),
            elevation: 0,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
