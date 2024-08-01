import 'package:flutter/material.dart';

import '../models/album.dart';
import '../services/album_service.dart';

class AlbumAddScreen extends StatefulWidget {
  const AlbumAddScreen({super.key});

  @override
  State<AlbumAddScreen> createState() => _AlbumAddScreenState();
}

class _AlbumAddScreenState extends State<AlbumAddScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;
  final AlbumService _albumService = AlbumService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Album',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('New Album'),
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
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Album Title'),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _futureAlbum = _albumService.createAlbum(_controller.text);
              });
            },
            child: const Text('Create Album'))
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
