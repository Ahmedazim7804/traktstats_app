import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/people/personItem.dart';



class PeopleWidget extends StatefulWidget {
  const PeopleWidget({super.key, required this.baseurl, required this.url});

  final String baseurl;
  final String url;

  @override
  State<PeopleWidget> createState() => _PeopleWidgetState();
}

class _PeopleWidgetState extends State<PeopleWidget> {

  int page = 0;

  void scrollDown() {
      if (page < 9) {
        setState(() {
          page = page + 1;
        });
      }
    }

    void scrollUp() {
      if (page > 0) {
        setState(() {
          page = page - 1;
        });
      }
    }


  Future<List<dynamic>> fetchData() async {

    var responses = await Future.wait([ 
      http.get(Uri.parse('${widget.baseurl}/${widget.url}')),
    ]);

    List<dynamic> actors = await jsonDecode(responses[0].body);
    
    return actors;
  }

  String getImage(String? imageUrl) {
    if (imageUrl != null) {
      return "https://image.tmdb.org/t/p/w200$imageUrl";
    }
    else {
      return "https://trakt.tv/assets/placeholders/thumb/zoidberg-3a8b0ba687e6a98c8a9d2f223993652d4278bc3bccf0e03cdfad579c2fe8a416.png";
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future: fetchData(), builder: (context, snapshot) {

      if (snapshot.hasData) {

        List<dynamic> onScreenNow = snapshot.data!.sublist((page*10), (page+1)*10);
        
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: Text("MOST WATCHED ${widget.url.toUpperCase()}", style: const TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                TextButton(onPressed: page > 0 ? scrollUp: null, child: Text(page > 0 ? "⤒ PREVIOUS ⤒" : "", style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova'),)),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                  ), 
                  itemCount: 10, 
                  itemBuilder: (BuildContext ctx, int index) {
                    final actor = onScreenNow[index];
                    return PersonItem(
                      name: actor['name'], 
                      image: getImage(actor['image']),
                      index: ((index+1) + (page*10)), 
                      movies: List<String>.from(actor['movies']), 
                      shows: List<String>.from(actor['shows']));
                    }
                  ),
                TextButton(onPressed: page < 9 ? scrollDown : null, child: Text(page < 9 ? "⤓ SEE MORE ⤓" : "", style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova'),))
              ],
            ),
          ),
        );
      }
      else {
        return const Center(child: CircularProgressIndicator(),);
      }
    });
  }
}