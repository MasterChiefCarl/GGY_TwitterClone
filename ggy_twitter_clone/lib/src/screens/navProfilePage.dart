import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class navProfilePage extends StatefulWidget {
  @override
  _profileState createState() => _profileState();

}

class _profileState extends State<navProfilePage>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: Center
          (
          child:



          SizedBox(
            height: 400,
            width: 300,
            child: Column(
                children: [
                  SizedBox(
                    height:50,
                    width: 200,

                    child: Center(
                      child: Text('Profile', style: GoogleFonts.quicksand(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:   const Color(0xff7b7b7b),

                      )),
                    ),
                  ),


                  SizedBox(
                    height:50,
                    width: 200,
                    child: Center(
                      child: Text('Under Maintenance', style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:   const Color(0xff7b7b7b),
                      )),
                    ),
                  ),



                ]
            ),
          ),
        )
    );
  }
}