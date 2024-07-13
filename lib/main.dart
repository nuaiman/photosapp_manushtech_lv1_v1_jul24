import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/init/screens/init_screen.dart';

void main() {
  runApp(const ProviderScope(child: PhotosApp()));
}

class PhotosApp extends StatelessWidget {
  const PhotosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photos App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InitScreen(),
    );
  }
}
