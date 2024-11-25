import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  var photosDir = '';
  List<String> photosList = [];

  @override
  void initState() {
    getApplicationCacheDirectory().then((dir) {
      setState(() {
        photosDir = dir.path;
        dir.listSync().toList().forEach((e) {
          if (e.path.endsWith('jpg')) photosList.add(e.path);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Photos'),
      ),
      body: Center(
        child: Column(
          children: [
            photosList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, idx) {
                        return ListTile(
                          leading: Image.file(
                            File(photosList[idx]),
                            width: 36,
                            height: 36,
                          ),
                          title: Text(photosList[idx]),
                        );
                      },
                    ),
                  )
                : const Text('No saved photos')
          ],
        ),
      ),
    );
  }
}
