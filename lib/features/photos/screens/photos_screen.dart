import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/photos/widgets/photo_widget.dart';

import '../../photos/notifiers/photos_notifier.dart';

class PhotosScreen extends ConsumerStatefulWidget {
  final int id;
  const PhotosScreen({super.key, required this.id});

  @override
  ConsumerState<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends ConsumerState<PhotosScreen> {
  int _pageIndex = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      updatePageIndex();
    }
  }

  void updatePageIndex() {
    if (_pageIndex == 5) {
      return;
    }
    setState(() {
      _pageIndex++;
    });
    print('-------------------- $_pageIndex ----------------------');
  }

  @override
  Widget build(BuildContext context) {
    final photos =
        ref.watch(photosProvider.notifier).getPhotosByAlbumId(widget.id);
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
    );
  }
}
