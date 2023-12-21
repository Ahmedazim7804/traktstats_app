import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/topItems.dart';

class TopMovies extends StatelessWidget {
  const TopMovies({super.key});

  Future<(Map<String, dynamic>, String)> fetchData() async {

    Map<String, dynamic> userTopMovies = await getData('movies/users_top_10');
    String username = await getData('username');

    return (userTopMovies, username);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TopItems(data: snapshot.data!.$1, username: snapshot.data!.$2, tv: false,);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}