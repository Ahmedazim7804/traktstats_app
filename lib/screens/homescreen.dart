import 'package:flutter/material.dart';
import 'package:traktstats/screens/mainscreen.dart';


class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController textController = TextEditingController();

    void submit(TextEditingController controller) {
      final String url = controller.text;

      if (Uri.parse(url).isAbsolute) {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {return MainScreen(baseurl: url);}));
      }
    }

    return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/trakt.png'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(controller: textController, style: const TextStyle(color: Colors.white), cursorColor: Colors.white, decoration: const InputDecoration(hintText: "http://127.0.0.1:8455", hintStyle: TextStyle(color: Colors.white54), label: Text("Server Url", style: TextStyle(color: Colors.white)))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (ctx) => MainScreen(baseurl: textController.text)));}, style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(200, 235, 28, 36)), child: const Text("Submit", style: TextStyle(color: Colors.white),),),
              )
            ],
          ),
        );
        // ListView(shrinkWrap: true, children: const [
        //   WelcomeWidget(),
        //   allTimeTotals(),
        //   FirstPlay(),
        //   TvShowStats(),
        //   TvCharts(),
        //   TopTvShows(),
        //   TraktMostWatchedShows(),
        //   TvGenres(),
        //   TvReleasedYear(),
        //   TvCountriesMap(),
        //   TvListProgress(),
        //   TvHighestRatedShows(),
        //   TvAllRatings(),
        //   ],)
  }
}