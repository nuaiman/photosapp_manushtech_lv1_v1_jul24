import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/init/notifiers/init_notifier.dart';

class InitScreen extends ConsumerWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(initProvider.notifier).initializeAlbumsAndPhotos(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 350,
            color: Colors.grey.shade800,
          ),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              'Fetching Gallery',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Please wait, a while...',
              style: TextStyle(fontSize: 24),
            ),
            trailing: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
