import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({Key? key}) : super(key: key);

  @override
  State<WifiPage> createState() => _WifiPageState();
}

bool _passwordVisible = false;

class _WifiPageState extends State<WifiPage> {
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
            height: 95.vh,
            width: 95.vw,
            child: Padding(
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
                        labelStyle: TextStyle(
                            foreground: Paint()..shader = linearGradient2,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
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
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.white38),
                      labelStyle: TextStyle(
                          foreground: Paint()..shader = linearGradient2,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      // Here is key idea
                      suffixIcon: IconButton(
                        icon: ShaderMask(
                          shaderCallback: (bounds) {
                            return RadialGradient(
                              center: Alignment.topLeft,
                              radius: 0.5,
                              colors: [
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
                  )
                ],
              ),
            )),
      ),
    );
  }
}

//TODO: Add keyboard enter thingy
//TODO: Add Save and clear button
//TODO: Add functionality