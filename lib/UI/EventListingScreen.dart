import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

import 'EventDetailsScreen.dart';

class EventListingScreen extends StatefulWidget {
  const EventListingScreen({Key? key}) : super(key: key);

  @override
  State<EventListingScreen> createState() => _EventListingScreenState();
}

class _EventListingScreenState extends State<EventListingScreen> {
  bool isLoaded = false;
  int _current = 0;

  AllEvents() async {
    setState(() {
      isLoaded = false;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .AllEvents()
        .then((value) async {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    AllEvents();
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
      backgroundColor: Color(0xffF9F6F6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Color(0xffC3C3C3).withOpacity(0.42),
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 8,
            color: COLOR_PURPLE,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 25, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    textScaleFactor: 1,
                    style: GoogleFonts.montserrat(
                        fontSize: 22,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Color(0xffC3C3C3).withOpacity(0.42),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 50,
          color: COLOR_WHITE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 22,
                  child: Image.asset(
                    'assets/tab1.png',
                    fit: BoxFit.cover,
                    color: COLOR_PURPLE,
                  ),
                ),
                Container(
                  width: 22,
                  child: Image.asset(
                    'assets/tab2.png',
                    fit: BoxFit.cover,
                    color: Color(0xff475464),
                  ),
                ),
                Container(
                  width: 23,
                  child: Image.asset(
                    'assets/tab3.png',
                    fit: BoxFit.cover,
                    color: Color(0xff475464),
                  ),
                ),
                Container(
                  width: 20,
                  child: Image.asset(
                    'assets/tab4.png',
                    fit: BoxFit.cover,
                    color: Color(0xff475464),
                  ),
                ),
                Container(
                  width: 22,
                  child: Image.asset(
                    'assets/tab5.png',
                    fit: BoxFit.cover,
                    color: Color(0xff475464),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: isLoaded == true
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recommended Events",
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 0.5,
                                  decorationThickness: 1.5,
                                  color: Color(0xff565066),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            disableCenter: true,
                            viewportFraction: 0.92,
                            aspectRatio: 2,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 4),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                                print(_current);
                              });
                            }),
                        items: providerListener.recommendedEventsList.map(
                          (item) {
                            int idx = providerListener.recommendedEventsList
                                .indexOf(item);

                            return Container(
                              child: InkWell(
                                onTap: () {
                                  push(
                                      context,
                                      EventDetailsScreen(
                                          (item.id ).toString()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: SizeConfig.screenWidth,
                                          height: SizeConfig.screenWidth! / 2,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.white,
                                            highlightColor: Colors.grey,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                color: Colors.white,
                                              ),
                                              width: double.infinity,
                                              height: 8.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth,
                                          decoration: new BoxDecoration(
                                              image:
                                                  (item.mainImage ?? "") == ""
                                                      ? DecorationImage(
                                                          image: AssetImage(
                                                            "assets/ban1.jpg",
                                                          ),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : DecorationImage(
                                                          image: NetworkImage(
                                                              (item.mainImage ??
                                                                  "")),
                                                          fit: BoxFit.cover,
                                                        ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.transparent),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [],
                                          ),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth,
                                          decoration: new BoxDecoration(
                                              color: Colors.transparent),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              (item.dateTime ?? "") == ""
                                                  ? Container()
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .access_time_rounded,
                                                            size: 20,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.9),
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            DateFormat.yMMMEd()
                                                                    .format(DateTime
                                                                        .parse(item
                                                                            .dateTime))
                                                                    .toString() +
                                                                ", " +
                                                                DateFormat.jm()
                                                                    .format(DateTime
                                                                        .parse(item
                                                                            .dateTime))
                                                                    .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.montserrat(
                                                                letterSpacing:
                                                                    0.5,
                                                                decorationThickness:
                                                                    1.5,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: SizeConfig
                                                                  .screenWidth! /
                                                              1.3,
                                                          child: Text(
                                                            item.name ?? "",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.montserrat(
                                                                letterSpacing:
                                                                    1,
                                                                decorationThickness:
                                                                    1.5,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 15,
                                                            child: Image.asset(
                                                              'assets/ticket.png',
                                                              fit: BoxFit.cover,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            (item.ticketsSold)
                                                                    .toString() +
                                                                " / " +
                                                                (item.maxTickets)
                                                                    .toString(),
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    letterSpacing:
                                                                        0,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  (item.friendsAttending ??
                                                              0) ==
                                                          0
                                                      ? Container()
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            child: Row(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      width: 25,
                                                                    ),
                                                                    Container(
                                                                      width: 15,
                                                                      height:
                                                                          15,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 1),
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(100)),
                                                                      ),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/profile_sample.jpg',
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      left: 5,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            15,
                                                                        height:
                                                                            15,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.black,
                                                                          border: Border.all(
                                                                              color: Colors.white,
                                                                              width: 1),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(100)),
                                                                        ),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/profile_sample.jpg',
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "+" +
                                                                      (item.friendsAttending)
                                                                          .toString() +
                                                                      " friends",
                                                                  style: GoogleFonts.montserrat(
                                                                      letterSpacing:
                                                                          0,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                  (item.friendsAttending ??
                                                              0) ==
                                                          0
                                                      ? Container()
                                                      : SizedBox(
                                                          width: 12,
                                                        ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: COLOR_SKY_BLUE,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 5),
                                                      child: Text(
                                                        currencySymbl +
                                                            " " +
                                                            (item.price ?? 0)
                                                                .toString(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                letterSpacing:
                                                                    0,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 15,
                        width: 16.0 *
                            providerListener.recommendedEventsList.length,
                        child: ListView.builder(
                            itemCount:
                                providerListener.recommendedEventsList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? COLOR_PURPLE
                                        : Colors.grey.shade300),
                              );
                            }),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Container(
                    color: COLOR_BACKGROUND,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All Events",
                                style: GoogleFonts.montserrat(
                                    letterSpacing: 0.5,
                                    decorationThickness: 1.5,
                                    color: Color(0xff565066),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: providerListener.eventsList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  push(
                                      context,
                                      EventDetailsScreen((providerListener
                                                  .eventsList[index].id ??
                                              "")
                                          .toString()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Card(
                                    elevation: 2,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                                  SizeConfig.screenWidth! / 2,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.white,
                                                highlightColor: Colors.grey,
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30.0),
                                                      topRight:
                                                          Radius.circular(30.0),
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  width: double.infinity,
                                                  height: 8.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                                  SizeConfig.screenWidth! / 2,
                                              decoration: new BoxDecoration(
                                                  image: (providerListener
                                                                  .eventsList[
                                                                      index]
                                                                  .mainImage ??
                                                              "") ==
                                                          ""
                                                      ? DecorationImage(
                                                          image: AssetImage(
                                                            "assets/ban1.jpg",
                                                          ),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : DecorationImage(
                                                          image: NetworkImage(
                                                              (providerListener
                                                                      .eventsList[
                                                                          index]
                                                                      .mainImage ??
                                                                  "")),
                                                          fit: BoxFit.cover,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30.0),
                                                    topRight:
                                                        Radius.circular(30.0),
                                                  ),
                                                  color: Colors.transparent),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [],
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                                  SizeConfig.screenWidth! / 2,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black.withOpacity(0),
                                                    Colors.black
                                                        .withOpacity(0.80)
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(30.0),
                                                  topRight:
                                                      Radius.circular(30.0),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                                  SizeConfig.screenWidth! / 2,
                                              decoration: new BoxDecoration(
                                                  color: Colors.transparent),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15,
                                                        vertical: 7),
                                                    child: Row(
                                                      children: [
                                                        (providerListener
                                                                        .eventsList[
                                                                            index]
                                                                        .isPartnered ??
                                                                    false) ==
                                                                false
                                                            ? Container()
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      COLOR_SKY_BLUE,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          3),
                                                                  child: Text(
                                                                    "Partnered",
                                                                    style: GoogleFonts.montserrat(
                                                                        letterSpacing:
                                                                            0,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.0,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                              ),
                                                        (providerListener
                                                                        .eventsList[
                                                                            index]
                                                                        .isPartnered ??
                                                                    false) ==
                                                                false
                                                            ? Container()
                                                            : SizedBox(
                                                                width: 10,
                                                              ),
                                                        (providerListener
                                                                        .eventsList[
                                                                            index]
                                                                        .sport ??
                                                                    "") ==
                                                                ""
                                                            ? Container()
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      COLOR_WHITE,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          3),
                                                                  child: Text(
                                                                    (providerListener
                                                                            .eventsList[index]
                                                                            .sport ??
                                                                        ""),
                                                                    style: GoogleFonts.montserrat(
                                                                        letterSpacing:
                                                                            0,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            13.0,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Container(
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          1.3,
                                                      child: Text(
                                                        providerListener
                                                                .eventsList[
                                                                    index]
                                                                .name ??
                                                            "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                letterSpacing:
                                                                    1,
                                                                decorationThickness:
                                                                    1.5,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  (providerListener
                                                                  .eventsList[
                                                                      index]
                                                                  .dateTime ??
                                                              "") ==
                                                          ""
                                                      ? Container()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .access_time_rounded,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.9),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 8),
                                                                  Text(
                                                                    DateFormat.yMMMEd()
                                                                            .format(DateTime.parse(providerListener
                                                                                .eventsList[
                                                                                    index]
                                                                                .dateTime))
                                                                            .toString() +
                                                                        ", " +
                                                                        DateFormat.jm()
                                                                            .format(DateTime.parse(providerListener.eventsList[index].dateTime))
                                                                            .toString(),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts.montserrat(
                                                                        letterSpacing:
                                                                            0.5,
                                                                        decorationThickness:
                                                                            1.5,
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.0,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    COLOR_SKY_BLUE,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          35),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          35),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        17,
                                                                    vertical:
                                                                        7),
                                                                child: Text(
                                                                  currencySymbl +
                                                                      " " +
                                                                      (providerListener.eventsList[index].price ??
                                                                              0)
                                                                          .toString(),
                                                                  style: GoogleFonts.montserrat(
                                                                      letterSpacing:
                                                                          0,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Total prize: ",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  letterSpacing:
                                                                      0.5,
                                                                  decorationThickness:
                                                                      1.5,
                                                                  color: Color(
                                                                      0xff475464),
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        Text(
                                                          currencySymbl +
                                                              (providerListener
                                                                          .eventsList[
                                                                              index]
                                                                          .price ??
                                                                      0)
                                                                  .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  letterSpacing:
                                                                      0.5,
                                                                  decorationThickness:
                                                                      1.5,
                                                                  color: Color(
                                                                      0xff475464),
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    LikeButton(
                                                      size: 28,
                                                      likeBuilder:
                                                          (bool isLiked) {
                                                        return Icon(
                                                          isLiked
                                                              ? Icons
                                                                  .favorite_rounded
                                                              : Icons
                                                                  .favorite_border_rounded,
                                                          color: isLiked
                                                              ? Colors.red
                                                              : Color(
                                                                  0xff475464),
                                                          size: 28,
                                                        );
                                                      },
                                                      circleColor: CircleColor(
                                                          start:
                                                              Color(0xffffffff),
                                                          end: Color(
                                                              0xffffffff)),
                                                      bubblesColor:
                                                          BubblesColor(
                                                        dotPrimaryColor:
                                                            Colors.red,
                                                        dotSecondaryColor:
                                                            COLOR_PURPLE,
                                                      ),
                                                    ),
                                                    /*Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                      color: Color(0xff475464),
                                                      size: 25,
                                                    ),*/
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.av_timer,
                                                      color: Color(0xff475464),
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 7),
                                                    Text(
                                                      "Event Creator: ",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              letterSpacing:
                                                                  0.5,
                                                              decorationThickness:
                                                                  1.5,
                                                              color:
                                                                  COLOR_SKY_BLUE,
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                      "Steve Jobs",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              letterSpacing:
                                                                  0.5,
                                                              decorationThickness:
                                                                  1.5,
                                                              color: Color(
                                                                  0xff475464),
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 18,
                                                      child: Image.asset(
                                                        'assets/ticket.png',
                                                        fit: BoxFit.cover,
                                                        color:
                                                            Color(0xff475464),
                                                      ),
                                                    ),
                                                    SizedBox(width: 7),
                                                    Container(
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          1.4,
                                                      child: Text(
                                                        (providerListener
                                                                    .eventsList[
                                                                        index]
                                                                    .ticketsSold)
                                                                .toString() +
                                                            "/" +
                                                            (providerListener
                                                                    .eventsList[
                                                                        index]
                                                                    .maxTickets)
                                                                .toString() +
                                                            " attending total",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts.montserrat(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            letterSpacing: 0.5,
                                                            decorationThickness:
                                                                1.5,
                                                            color: COLOR_PURPLE,
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 18,
                                                          child: Image.asset(
                                                            'assets/location.png',
                                                            fit: BoxFit.cover,
                                                            color: Color(
                                                                0xff475464),
                                                          ),
                                                        ),
                                                        SizedBox(width: 7),
                                                        Container(
                                                          width: SizeConfig
                                                                  .screenWidth! /
                                                              2,
                                                          child: Text(
                                                            (providerListener
                                                                        .eventsList[
                                                                            index]
                                                                        .location ??
                                                                    "")
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.montserrat(
                                                                letterSpacing:
                                                                    0.5,
                                                                decorationThickness:
                                                                    1.5,
                                                                color: Color(
                                                                    0xff475464),
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "1 km",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              letterSpacing:
                                                                  0.5,
                                                              decorationThickness:
                                                                  1.5,
                                                              color: Color(
                                                                  0xff475464),
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              height: SizeConfig.screenHeight! - 30,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: COLOR_PURPLE,
                  valueColor: AlwaysStoppedAnimation<Color>(COLOR_WHITE),
                ),
              ),
            ),
    );
  }
}
