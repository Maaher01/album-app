import 'package:flutter/material.dart';

import '../models/album.dart';
import '../services/album_service.dart';

class AlbumEditScreen extends StatefulWidget {
  final int albumId;
  final String title;

  const AlbumEditScreen(
      {super.key, required this.albumId, required this.title});

  @override
  State<AlbumEditScreen> createState() => _AlbumEditScreenState();
}

class _AlbumEditScreenState extends State<AlbumEditScreen> {
  late TextEditingController _controller;
  Future<Album>? _futureAlbum;
  final AlbumService _albumService = AlbumService();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.title);
    _futureAlbum = _albumService.fetchAlbum(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Album'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: buildColumn()),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
        ),
        ElevatedButton(
            onPressed: () async {
              final updatedAlbum = await _albumService.updateAlbum(
                  widget.albumId, _controller.text);

              if (mounted) {
                Navigator.pop(context, updatedAlbum);
              }
            },
            child: const Text('Submit'))
      ],
    );
  }
}
