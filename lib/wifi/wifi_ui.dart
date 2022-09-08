import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'wifisp.dart';
import "dart:math";
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({Key? key}) : super(key: key);

  @override
  State<WifiPage> createState() => _WifiPageState();
}

bool _passwordVisible = true;

class _WifiPageState extends State<WifiPage> {
  var userController = TextEditingController();
  var passController = TextEditingController();
  // bool switchEnabled = false;
  final _controller = ValueNotifier<bool>(false);
  int appStarts = 0;

  bool _isDisabled = true;

  @override
  void initState() {
    _isDisabled = false;
    print("1) IT IS FALSE");
    super.initState();
    MySharedPreferences.instance
        .getStringValue("appStarts")
        .then((value) => setState(() {
              if (value == '') {
                appStarts = 1;
              } else {
                appStarts = int.parse(value) + 1;
              }
              print("The value is" + appStarts.toString());
              MySharedPreferences.instance
                  .setStringValue("appStarts", appStarts.toString());
            }));
    print(appStarts);
    // if (appStarts == 0) {
    //   print("Why is this running");
    //   MySharedPreferences.instance
    //       .setBooleanValue("save", false)
    //       .then((value) => setState(() {
    //             _isDisabled = false;
    //             print("2) IT IS FALSE");
    //           }));
    // }
    MySharedPreferences.instance
        .getStringValue("user")
        .then((value) => setState(() {
              userController.text = value;
            }));
    MySharedPreferences.instance
        .getStringValue("pass")
        .then((value) => setState(() {
              passController.text = value;
            }));
    MySharedPreferences.instance
        .getBooleanValue("saved")
        .then((value) => setState(() {
              _isDisabled = value;
              print("3) IT IS " + _isDisabled.toString());
            }));
    MySharedPreferences.instance
        .getBooleanValue("service")
        .then((value2) => setState(() {
              _controller.value = value2;
            }));
    _analytics();
    _passwordVisible = false;

    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          MySharedPreferences.instance.setBooleanValue("service", true);
          if (_isDisabled) {
          } else {
            Fluttertoast.showToast(
                msg: "Error! Please enter Credentials",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          MySharedPreferences.instance.setBooleanValue("service", false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 174, 0, 243),
        Color.fromARGB(255, 250, 85, 250)
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    final Shader linearGradient2 = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 231, 134, 231),
        Color.fromARGB(255, 174, 0, 243),
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: SizedBox(
              height: 95.vh,
              width: 95.vw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('BITS WiFi Autologin',
                              style: TextStyle(
                                  // color: Colors.white,
                                  foreground: Paint()..shader = linearGradient,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ),
                        const SizedBox(height: 100),
                        TextFormField(
                          enabled: !_isDisabled,
                          textInputAction: TextInputAction.next,
                          controller: userController,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Color.fromARGB(255, 30, 35, 38),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              labelText: 'Username',
                              hintText: 'Enter your Username',
                              hintStyle: TextStyle(color: Colors.white38),
                              labelStyle: !_isDisabled
                                  ? TextStyle(
                                      foreground: Paint()
                                        ..shader = linearGradient2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)
                                  : TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          enabled: !_isDisabled,
                          controller: passController,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          //controller: _userPasswordController,
                          obscureText:
                              !_passwordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            filled: true,
                            fillColor: Color.fromARGB(255, 30, 35, 38),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.white38),
                            labelStyle: !_isDisabled
                                ? TextStyle(
                                    foreground: Paint()
                                      ..shader = linearGradient2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)
                                : TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: ShaderMask(
                                shaderCallback: (bounds) {
                                  return RadialGradient(
                                    center: Alignment.topLeft,
                                    radius: 0.5,
                                    colors: _isDisabled
                                        ? [Colors.grey, Colors.grey]
                                        : [
                                            Color.fromARGB(255, 174, 0, 243),
                                            Color.fromARGB(255, 231, 134, 231)
                                          ],
                                    tileMode: TileMode.mirror,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_isDisabled == false) {
                                if (userController.text != '' &&
                                    passController.text != '') {
                                  _isDisabled = !_isDisabled;
                                  print("6) IT IS" + _isDisabled.toString());
                                  MySharedPreferences.instance.setStringValue(
                                      "user", userController.text);
                                  MySharedPreferences.instance.setStringValue(
                                      "pass", passController.text);
                                  MySharedPreferences.instance
                                      .setBooleanValue("saved", true);
                                  print('Values saved');
                                  MySharedPreferences.instance
                                      .getStringValue("user")
                                      .then((v) => print(v + ' user'));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Error! Please enter Credentials",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                AlertDialog alert = AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 19, 18, 20),
                                  title: const Text('Delete Credentials',
                                      style: TextStyle(color: Colors.white)),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  content: Text(
                                      "Are you sure you want to delete your credential data?",
                                      style: TextStyle(color: Colors.white)),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        print('cancel');
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Confirm",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        MySharedPreferences.instance
                                            .removeValue("user");
                                        MySharedPreferences.instance
                                            .removeValue("pass");
                                        MySharedPreferences.instance
                                            .setBooleanValue("saved", false);

                                        userController.text = '';
                                        passController.text = '';
                                        print('removed');
                                        Navigator.pop(context);
                                        setState(() {
                                          _isDisabled = false;
                                          print("7) IT IS" +
                                              _isDisabled.toString());
                                          _controller.value = false;
                                        });
                                      },
                                    )
                                  ],
                                );

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            height: 50,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _isDisabled
                                      ? Text('Delete',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold))
                                      : Text('Save',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 30, 35, 38),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: !_isDisabled
                                  ? [
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(4, 4),
                                        blurRadius: 15,
                                        spreadRadius: 0.1,
                                      ),
                                      const BoxShadow(
                                        color: Colors.blue,
                                        offset: Offset(-4, -4),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _isDisabled
                                ? 'To edit credentials, press Delete'
                                : '',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              // <-- ElevatedButton
                              onPressed: () {
                                _login();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 30, 35, 38),
                              ),
                              child: Text(
                                'Manually Login',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 240.vw,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60.vw,
                                      child: Text('AutoLogin Service',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    //SizedBox(width: 10),
                                    AdvancedSwitch(
                                      controller: _controller,
                                      activeColor: Colors.blue,
                                      inactiveColor: Colors.grey,
                                      activeChild: Text('ON'),
                                      inactiveChild: Text('OFF'),
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(15)),
                                      width: 65.0,
                                      height: 30.0,
                                      enabled: false, //_isDisabled,
                                      disabledOpacity: 0.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

void _analytics() async {
  Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Wifi');
}

void _login() async {
  String user = await MySharedPreferences.instance.getStringValue("user");
  String pass = await MySharedPreferences.instance.getStringValue("pass");

  print('Running login');
  var list = [
    'https://fw.bits-pilani.ac.in:8090/httpclient.html',
    //'https://fw.bits-pilani.ac.in:8091/httpclient.html'
  ];
  final _random = new Random();
  var element = list[_random.nextInt(list.length)];
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request('POST', Uri.parse(element));
  request.bodyFields = {
    'username': user,
    'password': pass,
    'mode': '191',
    'producttype': '0',
    'a': DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
  };
  print(DateTime.now().toUtc().millisecondsSinceEpoch.toString());
  request.headers.addAll(headers);
  //http.StreamedResponse response = await request.send();

  String success =
      await "<?xml version='1.0' ?><requestresponse><status><![CDATA[LIVE]]></status><message><![CDATA[You are signed in as {username}]]></message><logoutmessage><![CDATA[You have successfully logged off]]></logoutmessage><state><![CDATA[]]></state></requestresponse> \n";
  request.headers.addAll(headers);
  try {
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      String pp = await response.stream.bytesToString();
      print(pp);
      print(success);
      print(pp == success);
      // print(identical(pp, success));
      if (pp == success) {
        Fluttertoast.showToast(
            msg: "Success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Error, couldn't login. Check Credentials.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      print(response.reasonPhrase);
      print('object');
      Fluttertoast.showToast(
          msg: "Error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } catch (_) {
    Fluttertoast.showToast(
        msg: "Error! Probably a Timeout/SocketException",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  /*try {
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 5));

    print(response.stream.bytesToString());
    if (response.statusCode == 200) {
      if (response.stream.bytesToString() == success) {
        print(response.reasonPhrase);
        print('1');
        Fluttertoast.showToast(
            msg: "Success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print(await response.stream.bytesToString());
        Fluttertoast.showToast(
            msg: "Error!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('2');
      }
    } else {
      print(response.reasonPhrase);
      print('1');
      Fluttertoast.showToast(
          msg: "Success!2",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
  //  }
 // } catch (_) {
    Fluttertoast.showToast(
        msg: "Error! Probably a Timeout/SocketException",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}*/
}
