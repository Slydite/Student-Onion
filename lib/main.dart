import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:resize/resize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Onion',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color.fromARGB(255, 30, 35, 38),
            secondary: Color.fromARGB(255, 30, 35, 38),
          ),
          primaryColor: Color.fromARGB(255, 30, 35, 38),
          canvasColor: const Color.fromARGB(255, 16, 20, 23),
          bottomSheetTheme: const BottomSheetThemeData(
            modalBackgroundColor: Color.fromARGB(255, 38, 38, 70),
            backgroundColor: Colors.transparent,
          ),
        ),
        home: const HomePage(),
      );
    });
  }
}
