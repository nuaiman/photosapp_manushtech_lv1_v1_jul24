import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/core/providers/loader_notifier.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/photos/widgets/photo_widget.dart';

import '../../photos/notifiers/photos_notifier.dart';

class PhotosScreen extends ConsumerStatefulWidget {
  final int id;
  const PhotosScreen({super.key, required this.id});

  @override
  ConsumerState<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(photosProvider.notifier).initIndex();
    _scrollController.addListener(() => _scrollListener(ref));
  }

  @override
  void dispose() {
    _scrollController.removeListener(() => _scrollListener(ref));
    _scrollController.dispose();
    super.dispose();
  }

  // void _scrollListener(WidgetRef ref) {
  //   if (_scrollController.positions.last.hasPixels) {
  //     ref.read(photosProvider.notifier).updateIndex();
  //   }
  // }

  void _scrollListener(WidgetRef ref) {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.7) {
      ref.read(photosProvider.notifier).updateIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    final photos =
        ref.watch(photosProvider.notifier).getPhotosByAlbumId(widget.id);
    final isLoading = ref.watch(loaderProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined),
            SizedBox(width: 4),
            Text('Photos'),
          ],
        ),
      ),
      body: photos.isNotEmpty
          ? ListView.separated(
              controller: _scrollController,
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
      bottomNavigationBar: photos.length > 25
          ? const SizedBox.shrink()
          : !isLoading
              ? const SizedBox.shrink()
              : const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
    );
  }
}
