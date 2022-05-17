import 'package:flutter/material.dart';
//import 'package:student_onion/wifi/wifilocal.dartb';
import 'home_page.dart';
import 'package:resize/resize.dart';
import 'wifi/wifisp.dart';
import 'package:cron/cron.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await MySharedPreferences.instance.getBooleanValue("service")) {
    var cron = new Cron();
    cron.schedule(new Schedule.parse('*/50-70 * * * *'), () async {
      _login();
    });
  }
  Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return MultiProvider(
      providers: [
        ChangeNotifierProvider<Credentials>(
            create: (BuildContext context) => Credentials()),
      ],
      child:*/
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

void _login() async {
  String user = await MySharedPreferences.instance.getStringValue("user");
  String pass = await MySharedPreferences.instance.getStringValue("pass");
  bool auto = await MySharedPreferences.instance.getBooleanValue("service");

  //user = Uri.encodeComponent(user);
  //pass = Uri.encodeComponent(pass);
  print(user + pass);
  print(auto);

  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request(
      'POST', Uri.parse('https://fw.bits-pilani.ac.in:8090/httpclient.html'));
  request.bodyFields = {
    'username': user,
    'password': pass,
    'mode': '191',
    'producttype': '0',
    'a': '1647846888240'
  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
    print('object');
  }
}
