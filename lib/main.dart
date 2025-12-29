import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'HomeScreenState.dart';

void main() {
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => AppData(),
    //   child: const MyApp(),
    // ),
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget  {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}
