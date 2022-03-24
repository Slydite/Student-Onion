import 'package:flutter/material.dart';
import 'wifi/wifi_ui.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

int? index = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget widgetForBody = WifiPage();
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    index = DefaultTabController.of(context)?.index;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
          child: AdvancedDrawer(
        backdropColor: Color.fromARGB(255, 16, 20, 23),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        openRatio: 0.55,
        //openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(255, 44, 44, 44),
              //offset: Offset(4, 4),
              blurRadius: 30,
              spreadRadius: 18,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? Icons.clear : Icons.menu,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )),
            //body: const TabBarView(children: [ Text('Test', style: TextStyle(color: Colors.white)),DonePage()], )
            body: widgetForBody),
        // body: Text('Test', style: TextStyle(color: Colors.white))),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 80),
                  Container(
                    width: 150.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      //bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 16, 20, 23),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Student\'s Onion',
                          style: TextStyle(
                              color: Color.fromARGB(255, 217, 0, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        widgetForBody = WifiPage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Icon(Icons.wifi, color: Colors.white),
                          SizedBox(width: 15),
                          Text('Wifi AutoLogin',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ]),
                      )),
                  SizedBox(height: 15),
                  GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Icon(Icons.location_pin, color: Colors.white),
                          SizedBox(width: 15),
                          Text('Heatmap [In dev]',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ]),
                      )),
                  /* ListTile(
                    onTap: () {},
                    leading: Icon(Icons.favorite),
                    title: Text('Favourites'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),*/
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Github'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
