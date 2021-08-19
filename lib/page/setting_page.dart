import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';

class SettingPage extends StatelessWidget {
  static String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Setting',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w900),
            )),
        body: Material(
            child: ListTile(
                title: Text('Daily reminder'),
                trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      scheduled.scheduledRestaurant(value);
                      
                    },
                  );
                }))));
  }
}
