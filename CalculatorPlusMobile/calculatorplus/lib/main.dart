import 'package:calculatorplus/Screens/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'Providers/User.dart';
import 'Screens/CalcScreen.dart';
import 'Storage/checkSign.dart';
import 'package:provider/provider.dart';

void main() {
  /*
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  */
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => User()), //User Provider
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    checkSign(context);
    return MaterialApp(
      title: 'Calculator+',
      home: !context.read<User>().checkedIn ? const FirstScreen() : const CalcScreen(),
      routes:{
        '/calc': (context) => const CalcScreen(),
      }
    );
  }
}
