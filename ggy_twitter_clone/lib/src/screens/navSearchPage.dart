import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/src/widgets/search.dart';
import 'package:google_fonts/google_fonts.dart';

class navSearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<navSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   title: const Text('Search for Users'),
      //   actions:[
          
      //   ],
      // ),
        body: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SizedBox(
            height: 150,
            width: 200,
            child: Center(
              child: Text('Search',
                  style: GoogleFonts.quicksand(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff7b7b7b),
                  )),
            ),
          ),
          Center(child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              IconButton(
                icon:const Icon(Icons.people),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate:CustomSearchPeople()
                  );
                }
              ),
              IconButton(
                icon:const Icon(Icons.edit),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate:CustomSearchHandle()
                  );
                }
              ),
            ],
          )),
          SizedBox(
            height: 150,
            width: 300,
            child: Center(
              child: Text('Click the Search Button to start Searching!',
              textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff7b7b7b),
                  )),
            ),
          ),
        ]),
      ),
    ));
  }
}
