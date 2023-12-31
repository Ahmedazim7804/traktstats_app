import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HighestRated extends StatelessWidget {
  const HighestRated({super.key, required this.data, required this.tv});

  final Map<String, dynamic> data;
  final bool tv;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: Colors.grey.withAlpha(25),
      child: Center(
        child: Column(
          children: [
            Container(margin: const EdgeInsets.all(16),padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: Text("HIGHEST RATED ${tv ? "TV SHOWS" : "MOVIES"}", style: const TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: SizedBox(height: 300, child: ListView(scrollDirection: Axis.horizontal, shrinkWrap: true, controller: ScrollController(keepScrollOffset: false), children: data.entries.map((item) => ShowItem(image: item.value['poster'], rating: item.value['rating'])).toList())),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowItem extends StatelessWidget {
  const ShowItem({super.key, required this.image, required this.rating});

  final String image;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: "https://image.tmdb.org/t/p/w200$image",),
          RatingItem(rating: rating,)
        ],
      ),
    );
  }
}

class RatingItem extends StatelessWidget {
  const RatingItem({super.key, required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RatingTriangle(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        alignment: Alignment.topCenter,
        height: 50,
        width: 50,
        color: Colors.red,
        child: Transform.rotate(angle: (math.pi / 4), child: Text("$rating", style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova', fontWeight: FontWeight.bold, fontSize: 20),)),
      ),
    );
  }
}

class RatingTriangle extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}