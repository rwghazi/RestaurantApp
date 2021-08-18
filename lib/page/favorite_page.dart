import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatelessWidget {
  static String routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Favorit',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
          )),
    );
  }
}
