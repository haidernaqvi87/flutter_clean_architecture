import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final String imageUrl;

  const ImageDisplay({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl,
        placeholder: (context, url) =>
            CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Icon(Icons.error),
        fit: BoxFit.cover,);
  }
}
