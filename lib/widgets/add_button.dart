import 'package:flutter/material.dart';
import '../screens/album_add.dart';
import '../models/album.dart';

class AddButton extends StatelessWidget {
  final Function(Album) onAlbumAdded;

  const AddButton({super.key, required this.onAlbumAdded});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.add_circle_outlined, size: 56),
        onPressed: () async {
          final newAlbum = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AlbumAddScreen(),
            ),
          );
          if (newAlbum != null) {
            onAlbumAdded(newAlbum);
          }
        });
  }
}
