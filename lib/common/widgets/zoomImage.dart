import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImage extends StatefulWidget {
  final String imageUrl;
  final File imageFile;

  const ZoomImage({Key key, this.imageUrl, this.imageFile}) : super(key: key);
  @override
  _ZoomImageState createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        loadingBuilder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        imageProvider: widget.imageFile != null
            ? FileImage(widget.imageFile)
            : NetworkImage(widget.imageUrl),
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
