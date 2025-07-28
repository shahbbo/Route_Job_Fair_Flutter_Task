import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/photo_model.dart';

class PhotoGridItem extends StatelessWidget {
  final PhotoModel photo;

  const PhotoGridItem({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: photo.src.large,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
