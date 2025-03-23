import 'dart:convert';
import 'dart:math';

import 'package:feed_demo/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late String data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final res = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=nature&per_page=5'),
      headers: {'Authorization': 'api_key', 'Content-Type': 'application/json'},
    );
    // print(res.statusCode);
    if (res.statusCode == 200) {
      List photos = jsonDecode(res.body)['photos'];

      // Pick a random image from the list
      if (photos.isNotEmpty) {
        var randomPhoto = photos[Random().nextInt(photos.length)];
        setState(() {
          data = randomPhoto['src']['original']; // Use full-resolution image
          isLoading = false;
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading ? CircularProgressIndicator() : Image.network(data),
    );
  }
}
