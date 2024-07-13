import 'package:flutter/material.dart';
import 'package:photosapp_manushtech_lv1_v1_jul24/models/photo.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;
  const PhotoWidget({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => Dialog(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.network(photo.url),
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 18,
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Theme.of(context).cardColor,
          child: FittedBox(child: Text(photo.id.toString())),
        ),
      ),
      title: Text(photo.title),
      trailing: CircleAvatar(
        backgroundColor: Theme.of(context).cardColor,
        backgroundImage: NetworkImage(photo.thumbnailUrl),
      ),
    );
  }
}
