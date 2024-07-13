import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/photos/widgets/photo_widget.dart';

import '../../photos/notifiers/photos_notifier.dart';

class PhotosScreen extends ConsumerWidget {
  final int id;
  const PhotosScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(photosProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Photos'),
      ),
      body: photos.isNotEmpty
          ? ListView.separated(
              itemCount: photos.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final photo = photos[index];
                return PhotoWidget(
                  photo: photo,
                );
              },
            )
          : const Center(
              child: Icon(Icons.hourglass_empty),
            ),
    );
  }
}
