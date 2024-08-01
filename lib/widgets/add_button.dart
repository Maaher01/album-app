import 'package:flutter/material.dart';
import '../screens/album_add.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.add_circle_outlined, size: 56),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AlbumAddScreen(),
            ),
          );
        });
  }
}
