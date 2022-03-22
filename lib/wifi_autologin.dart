import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class DonePage extends StatefulWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  State<DonePage> createState() => _DonePageState();
}

bool _passwordVisible = false;

class _DonePageState extends State<DonePage> {
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
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
                            color: Colors.green,
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
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    autofocus: true,
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
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      // Here is key idea
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.green,
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
//TODO: Add gradient colours
//TODO: Add keyboard enter thingy
//TODO: Add Save and clear button
//TODO: Add functionality