import 'package:flutter/material.dart';
import 'wifi_autologin.dart';

int? index = 0;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    index = DefaultTabController.of(context)?.index;
    return DefaultTabController(
      length: 1,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [ButtonBar()],
              )),
          body: const TabBarView(
            children: [
              DonePage(),
            ],
          ),
        ),
      ),
    );
  }
}
