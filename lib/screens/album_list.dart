import 'dart:async';
import 'package:album_app/screens/album_edit.dart';
import 'package:flutter/material.dart';

import '../widgets/album_card.dart';
import '../widgets/add_button.dart';
import '../models/album.dart';
import '../services/album_service.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  late Future<List<Album>> futureAlbums;
  List<Album> albums = [];
  final AlbumService _albumService = AlbumService();

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  Future<void> fetchAlbums() async {
    final data = await _albumService.fetchAlbums();
    setState(() {
      albums = data;
    });
  }

  void addAlbum(Album album) {
    setState(() {
      albums.insert(0, album);
    });
  }

  void removeAlbum(int albumId) {
    setState(() {
      albums.removeWhere((album) => album.id == albumId);
    });
  }

  Future<void> editAlbum(int albumId, String title) async {
    final updatedAlbum = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AlbumEditScreen(
          albumId: albumId,
          title: title,
        ),
      ),
    );

    if (updatedAlbum != null) {
      fetchAlbums();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Albums'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<List<Album>>(
            future: futureAlbums,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading spinner.
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                return Stack(children: [
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: albums.map((album) {
                          return AlbumCard(
                            title: album.title,
                            albumId: album.id,
                            onDelete: () => removeAlbum(album.id),
                            onEdit: () => editAlbum(album.id, album.title),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: AddButton(onAlbumAdded: addAlbum),
                  ),
                ]);
              } else {
                return const Text("No data available");
              }
            },
          );
        },
      ),
    );
  }
}
