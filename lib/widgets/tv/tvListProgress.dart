import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/listProgress.dart';

class TvListProgress extends StatelessWidget {
  const TvListProgress({super.key});

  Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> tvList = await getData('tv/list_progress');

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