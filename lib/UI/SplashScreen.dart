import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/Helpers/constants.dart';
import 'package:tic_tac_toe/Helpers/helper.dart';
import 'package:tic_tac_toe/Helpers/size_config.dart';

import 'EventListingScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icon color
      systemNavigationBarIconBrightness:
          Brightness.light, // color of navigation controls
    ));
    Future.delayed(const Duration(seconds: 2), () {
      push(context, EventListingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight,
          color: COLOR_PURPLE,
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(10),
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: SizeConfig.screenWidth! / 3.5,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.refresh,
                              color: Colors.white.withOpacity(0.67),
                              size: 25,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: SizeConfig.screenWidth! / 1.2,
                              child: Text(
                                "© 2020 Are You In app. All rights reserved",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    letterSpacing: 0.5,
                                    color: Colors.white.withOpacity(0.67),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
