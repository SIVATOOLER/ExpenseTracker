import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var kColor = ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(233, 228, 246, 211));
    var kDarkColor =
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(233, 14, 21, 51));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(233, 14, 21, 51),
        bottomSheetTheme: BottomSheetThemeData()
            .copyWith(backgroundColor: kDarkColor.onSecondaryContainer),
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kDarkColor.onPrimaryContainer,
            foregroundColor: kDarkColor.primaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColor.primaryContainer),
        ),
        useMaterial3: true,
        colorScheme: kDarkColor,
        cardTheme: const CardTheme().copyWith(
            color: kDarkColor.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
      ),
      theme: ThemeData().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(233, 213, 245, 182),
          useMaterial3: true,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColor.onPrimaryContainer,
              foregroundColor: kColor.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color: kColor.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kColor.primaryContainer)),
          bottomSheetTheme: const BottomSheetThemeData()
              .copyWith(backgroundColor: kColor.secondaryContainer),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: const TextStyle(
                    color: Color.fromARGB(233, 41, 66, 14),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )),
      home: const HomeScreen(),
    );
  }
}
