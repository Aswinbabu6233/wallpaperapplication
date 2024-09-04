import 'dart:convert';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:wallpaperapplication/model/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String apiKey =
      "lHKgk3tDVPj3kX6SJtJJf4E88hNmwNqhKaUVFwcA4rEJN3poamdxA9Af";
  final String baseURL = "https://api.pexels.com/v1/";

  Future<List<images>> getimageList({required int? pagenumber}) async {
    String url = '';
    if (pagenumber == null) {
      url = '${baseURL}curated?per_page=80';
    } else {
      url = '${baseURL}curated?per_page=80&page=$pagenumber';
    }
    List<images> imageList = [];
    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': apiKey});
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = json.decode(response.body);
        for (final json in jsonData['photos'] as Iterable) {
          final image = images.fromJson(json);
          imageList.add(image);
        }
      }
    } catch (_) {}
    return imageList;
  }

  Future<images> getImageById({required int id}) async {
    final url = '${baseURL}photos/$id';
    images image = images.emptyConstructor();

    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': apiKey});
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = json.decode(response.body);
        image = images.fromJson(jsonData);
      }
    } catch (e) {}
    return image;
  }

  Future<List<images>> getImagesBySearch({required String query}) async {
    final url = '${baseURL}search?query=$query&per_page=80';
    List<images> imageList = [];

    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': apiKey});
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = json.decode(response.body);
        for (final json in jsonData['photos'] as Iterable) {
          final image = images.fromJson(json);
          imageList.add(image);
        }
      }
    } catch (_) {}
    return imageList;
  }

  Future<void> downloadImage(
      {required String imageURL,
      required int imageID,
      required BuildContext context}) async {
    try {
      final response = await http.get(Uri.parse(imageURL));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final bytes = response.bodyBytes;
        final directory = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS);

        final file = File('$directory/$imageID.png');
        await file.writeAsBytes(bytes);
        MediaScanner.loadMedia(path: file.path);
        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              content: Text("File's been saved at: ${file.path}")));
        }
      }
    } catch (_) {}
  }
}
