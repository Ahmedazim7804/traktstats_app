import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:transparent_image/transparent_image.dart';

class FirstPlay extends StatelessWidget {
  const FirstPlay({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    final firstPlay = await getData('first_play');
    
    return firstPlay;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(
                            child: Column(
                              children: [
                                Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("FIRST PLAY", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                                const SizedBox(height: 25,),
                                FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: snapshot.data!['movie_logo']!, placeholderCacheHeight: 256, placeholderCacheWidth: 256),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('\ue628', style: TextStyle(fontFamily: 'Trakt', fontSize: 50, color: Colors.white),),
                                    const SizedBox(width: 15,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!['date'], style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova', fontSize: 17, fontWeight: FontWeight.bold),),
                                        Text(snapshot.data!['time'], style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova'))
                                      ])
                                  ],
                                )
                              ],
                            ),
                          ),
                    );
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}