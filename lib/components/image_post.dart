import 'package:flutter/material.dart';
import 'package:image_storage/services/storage/storage_service.dart';
import 'package:provider/provider.dart';

class ImagePost extends StatelessWidget {
  final String imageUrl;
  const ImagePost({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, child) => Container(
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              // image post
              Image.network(
                imageUrl,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  } else {
                    return child;
                  }
                },
              ),
              // delete button
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.grey[900],
                  size: 30,
                ),
                onPressed: () => storageService.deleteImage(imageUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
