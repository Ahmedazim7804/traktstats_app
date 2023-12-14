import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, String>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/pfp')),
      http.get(Uri.parse('$baseurl/username')),
    ]);
    String pfp = responses[0].body;
    String username = responses[1].body;
    return {
      'pfp': pfp,
      'username': username
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Center(
                            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 36,
                      height: 36,
                      imageUrl: snapshot.data!['pfp']!,
                      ),
                    ),
                    const SizedBox(width: 25,),
                    Text(snapshot.data!['username']!, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontFamily: 'ProximaNova'),)
                  ],
                ),
                Text("All Time", style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 100, letterSpacing: -5)),
                const Text("1923 → 2023 STATS", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'ProximaNova', letterSpacing: 2),),
                TextButton(onPressed: () {}, style: TextButton.styleFrom(shape: const RoundedRectangleBorder(), backgroundColor: const Color.fromARGB(255, 51, 56, 62)), child: const Text("CHOOSE YEARS", style: TextStyle(color: Colors.white),),)
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