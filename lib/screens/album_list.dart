import 'dart:async';
import 'package:flutter/material.dart';

import '../widgets/album_card.dart';
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
    futureAlbums = _albumService.fetchAlbums();
    futureAlbums.then((data) {
      setState(() {
        albums = data;
      });
    });
  }

  void removeAlbum(int albumId) {
    setState(() {
      albums.removeWhere((album) => album.id == albumId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'All Albums',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Scaffold(
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
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: albums.map((album) {
                            return AlbumCard(
                              text: album.title,
                              albumId: album.id,
                              onDelete: () => removeAlbum(album.id),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    return const Text("No data available");
                  }
                },
              );
            },
          ),
        ));
  }
}
