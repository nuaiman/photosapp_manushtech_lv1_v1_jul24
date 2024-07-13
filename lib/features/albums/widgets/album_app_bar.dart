import 'package:flutter/material.dart';

import 'album_search_field.dart';

class AlbumAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AlbumAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_library_outlined),
          SizedBox(width: 4),
          Text('Albums'),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: const Padding(
          padding: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: AlbumSearchField(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
