import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapplication/repository/repository.dart';

class Privewpage extends StatefulWidget {
  const Privewpage({super.key, required this.imageUrl, required this.imageID});
  final String imageUrl;
  final int imageID;

  @override
  State<Privewpage> createState() => _PrivewpageState();
}

class _PrivewpageState extends State<Privewpage> {
  Repository repo = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
        foregroundColor: Color.fromRGBO(255, 255, 255, 0.6),
        shape: CircleBorder(),
        onPressed: () {
          repo.downloadImage(
              imageURL: widget.imageUrl,
              imageID: widget.imageID,
              context: context);
        },
        child: Icon(
          Icons.download,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
