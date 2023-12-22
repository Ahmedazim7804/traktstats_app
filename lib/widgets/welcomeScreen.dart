import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traktstats/getData.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  Future<Map<String, String>> fetchData() async {
    final String pfp = await getData<String>('pfp');
    final String username = await getData('username');
    
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
                const SizedBox(height: 16,),
                Text("All Time Stats", textAlign: TextAlign.center,style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 100, height: 0.9, letterSpacing: -5)),
                //const Text("STATS", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'ProximaNova', letterSpacing: 2),),
                //TextButton(onPressed: () {}, style: TextButton.styleFrom(shape: const RoundedRectangleBorder(), backgroundColor: const Color.fromARGB(255, 51, 56, 62)), child: const Text("CHOOSE YEARS", style: TextStyle(color: Colors.white),),)
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