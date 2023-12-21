import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class TopItems extends StatelessWidget {
  const TopItems({super.key, required this.data, required this.tv, required this.username});

  final Map<String, dynamic> data;
  final bool tv;
  final String username;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Colors.grey.withAlpha(25),
      child: Center(
        child: Column(
          children: [
            Text("$username's Top ${tv ? "Shows" : "Movies"}", style: GoogleFonts.passionOne(color: const Color.fromARGB(255, 232, 230, 227), fontSize: 30, fontWeight: FontWeight.w400),),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: GridView.count(scrollDirection: Axis.vertical, controller: ScrollController(keepScrollOffset: false), crossAxisSpacing: 7, childAspectRatio: 0.6, shrinkWrap: true, crossAxisCount: 2, children: data.entries.map((item) => ShowItem(image: item.value['poster'], runtime: item.value['runtime'])).toList()),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowItem extends StatelessWidget {
  const ShowItem({super.key, required this.image, required this.runtime});

  final String image;
  final String runtime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: "https://image.tmdb.org/t/p/w200$image",),
        Text(runtime, style: const TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, fontSize: 11, color: Colors.white),),
      ],
    );
  }
}