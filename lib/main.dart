import 'package:flutter/material.dart';

import 'styles/theme.dart';
import 'screens/main_screens/home_screen.dart';
import 'screens/main_screens/client_profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: getTheme(),
      home: HomeScreen(title: 'Easier'),
      routes: {
        ClientProfileScreen.routeName: (context) => ClientProfileScreen(),
      },
    );
  }
}
