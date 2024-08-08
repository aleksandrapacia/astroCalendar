import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_provider.dart';
import 'home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EventProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Astronomy Calendar',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
