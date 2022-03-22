import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tic_tac_toe/Helpers/constants.dart';
import 'package:tic_tac_toe/Helpers/helper.dart';
import 'package:tic_tac_toe/Helpers/size_config.dart';
import 'package:tic_tac_toe/View%20Models/CustomViewModel.dart';
import 'package:intl/intl.dart';

class ConfirmedOrderScreen extends StatefulWidget {
  @override
  State<ConfirmedOrderScreen> createState() => _ConfirmedOrderScreenState();
}

class _ConfirmedOrderScreenState extends State<ConfirmedOrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenWidth! / 1.5,
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: 8.0,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenWidth! / 1.5,
                  decoration: new BoxDecoration(
                      image: (providerListener.eventDetails!.mainImage ?? "") ==
                              ""
                          ? DecorationImage(
                              image: AssetImage(
                                "assets/ban1.jpg",
                              ),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: NetworkImage(
                                  (providerListener.eventDetails!.mainImage ??
                                      "")),
                              fit: BoxFit.cover,
                            ),
                      color: Colors.transparent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenWidth! / 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.80)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: SlidingUpPanel(
                parallaxEnabled: true,
                minHeight: SizeConfig.screenHeight! / 1.3,
                maxHeight: SizeConfig.screenHeight! * 2,
                isDraggable: true,
                backdropEnabled: true,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                panel: Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 5,
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Color(0xffB9BAC0),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Purchase Success ",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                letterSpacing: 0.5,
                                                decorationThickness: 1.5,
                                                color: Color(0xff120936),
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          pop(context);
                                        },
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Color(0xffB9BAC0),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: new BoxDecoration(
                                          boxShadow: [
                                            new BoxShadow(
                                              color: Color(0xffC3C3C3)
                                                  .withOpacity(0.2),
                                              blurRadius: 20.0,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: COLOR_GREEN,
                                          size: 80,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Thank You!",
                                        style: GoogleFonts.montserrat(
                                            letterSpacing: 0.5,
                                            decorationThickness: 1.5,
                                            color: Colors.black,
                                            fontSize: 37.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth! / 1.1,
                                    child: Text(
                                      "Your your payment was made successfully!",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 1,
                                          decorationThickness: 1.5,
                                          color: Color(0xff475464),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    color: Color(0xffE5E4EB),
                                    thickness: 1.5,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth! / 1.1,
                                    child: Text(
                                      "You booking ID",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 1,
                                          decorationThickness: 1.5,
                                          color: Color(0xff475464),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth! / 1.1,
                                    child: Text(
                                      "#33475480",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 1,
                                          decorationThickness: 1.5,
                                          color: COLOR_SKY_BLUE,
                                          fontSize: 34.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth! / 1.1,
                                    child: Text(
                                      "You will need this booking ID to enter inside the event. You can view this code inside your profile / booked events",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 1,
                                          decorationThickness: 1.5,
                                          color: Color(0xff475464),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  pop(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff936EFE),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Center(
                      child: Text(
                        "CLOSE",
                        style: GoogleFonts.montserrat(
                            letterSpacing: 0.5,
                            decorationThickness: 1.5,
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 30),
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ));
  }
}
