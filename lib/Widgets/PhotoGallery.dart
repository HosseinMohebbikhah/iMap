import 'package:flutter/material.dart';

class PhotoGallery extends StatelessWidget {
  final List<String> photoUrls;

  PhotoGallery({required this.photoUrls});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: photoUrls.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ((photoUrls.length < 3)
              ? photoUrls.length
              : 3), // number of columns
          crossAxisSpacing: 4.0, // spacing between columns
          mainAxisSpacing: 4.0, // spacing between rows
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenPhoto(photoUrl: photoUrls[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(photoUrls[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenPhoto extends StatelessWidget {
  final String photoUrl;

  FullScreenPhoto({required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(photoUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
