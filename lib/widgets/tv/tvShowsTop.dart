import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/topItems.dart';

class TopTvShows extends StatelessWidget {
  const TopTvShows({super.key});

  Future<(Map<String, dynamic>, String)> fetchData() async {
    Map<String, dynamic> userTopShows = await getData('tv/users_top_10');
    String username = await getData<String>('username');

    return (userTopShows, username);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TopItems(data: snapshot.data!.$1, username:snapshot.data!.$2 ,tv: true,);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}