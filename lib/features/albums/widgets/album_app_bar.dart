import 'package:flutter/material.dart';

import 'album_search_field.dart';

class AlbumAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AlbumAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('Albums'),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: AlbumSearchField(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
