import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/features/albums/notifiers/albums_search_notifier.dart';

class AlbumSearchField extends ConsumerStatefulWidget {
  const AlbumSearchField({super.key});

  @override
  ConsumerState<AlbumSearchField> createState() => _AlbumSearchFieldState();
}

class _AlbumSearchFieldState extends ConsumerState<AlbumSearchField> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void clearControllerAndUnfocus(WidgetRef ref) {
    setState(() {
      _searchController.clear();
    });
    FocusManager.instance.primaryFocus!.unfocus();

    ref.read(albumsSearchProvider.notifier).updateState('');
  }

  void updateSearchTerm(WidgetRef ref, String searchTerm) {
    ref.read(albumsSearchProvider.notifier).updateState(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    final albumsSearchTerm = ref.watch(albumsSearchProvider);
    return TextField(
      controller: _searchController,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      onChanged: (value) {
        updateSearchTerm(ref, value);
      },
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: () {
            clearControllerAndUnfocus(ref);
          },
          child: albumsSearchTerm.isEmpty
              ? const Opacity(
                  opacity: 0,
                  child: Icon(Icons.done),
                )
              : const Icon(Icons.close),
        ),
      ),
    );
  }
}
