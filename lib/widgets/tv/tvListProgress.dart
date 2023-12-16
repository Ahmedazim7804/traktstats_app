import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/listProgress.dart';

class TvListProgress extends StatelessWidget {
  const TvListProgress({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/list_progress')),
    ]);

    Map<String, dynamic> tvList = await jsonDecode(responses[0].body);

    return tvList;
  }
    

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return ListProgress(data: snapshot.data!, tv: true);

            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}