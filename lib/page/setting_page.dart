import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatelessWidget {
  static String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Setting',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
          )),
    );
  }
}
