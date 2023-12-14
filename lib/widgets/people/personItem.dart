import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class PersonItem extends StatelessWidget {
  const PersonItem({super.key, required this.name, required this.image, required this.index, required this.movies, required this.shows});

  final String name;
  final String image;
  final List<String> movies;
  final List<String> shows;
  final int index;

  Widget get toolTip {

    final moviesTextWidget = movies.map((movie) => Text(movie, style: const TextStyle(color: Colors.white70, fontSize: 10),)).toList();
    final showsTextWidget = shows.map((show) => Text(show, style: const TextStyle(color: Colors.white70, fontSize: 10),)).toList();

    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...moviesTextWidget,
            shows.isNotEmpty ? const SizedBox(width: 20, child: Divider(color: Colors.white)) : const SizedBox.shrink(),
            ...showsTextWidget
          ],
        ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          Stack(children: [
            JustTheTooltip(
              content: toolTip,
              triggerMode: TooltipTriggerMode.tap,
              backgroundColor: Colors.black.withOpacity(0.7),
              child: CircleAvatar(maxRadius: 60, minRadius: 50,backgroundImage: CachedNetworkImageProvider(image)),
            ),
            Text("$index", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)
          ],),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'ProximaNova',overflow: TextOverflow.ellipsis))),
          Text(movies.isNotEmpty ? "${movies.length} MOVIES" : '', style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'ProximaNova')),
          Text(shows.isNotEmpty ? "${shows.length} SHOWS" : '', style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600, fontFamily: 'ProximaNova')),
        ],
      )
      );
  }
}