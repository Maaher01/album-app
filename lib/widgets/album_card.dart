import 'package:flutter/material.dart';
import '../services/album_service.dart';

class AlbumCard extends StatelessWidget {
  final AlbumService _albumService = AlbumService();

  AlbumCard(
      {super.key,
      required this.text,
      required this.albumId,
      required this.onDelete});

  final String text;
  final int albumId;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    style: const TextStyle(fontSize: 14.5),
                    text,
                    softWrap: true,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.create,
                  color: Colors.green,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await _albumService.deleteAlbum(albumId);
                    onDelete();
                  },
                )
              ],
            )),
      ),
    );
  }
}
