import 'package:bookd/provider/login_data.dart';
import 'package:bookd/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => FriendProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AllFriendProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AllProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Bookd',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 122, 54, 240),
            secondary: Color.fromARGB(255, 255, 182, 64),
            secondaryContainer: Color.fromARGB(255, 255, 237, 207),
            error: Colors.red),
      ),
      home: const SplashScreen(),
    );
  }
}
