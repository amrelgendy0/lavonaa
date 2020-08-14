import 'package:lavona/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:lavona/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize())
  ],
    child: MyApp(),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lavona',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: splash_screen()
    );
  }
}

