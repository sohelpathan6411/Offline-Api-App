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

import 'ConfirmedOrderScreen.dart';

class EventDetailsScreen extends StatefulWidget {
  final String id;

  EventDetailsScreen(this.id);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isLoaded = false;
  int _current = 0;
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  EventDetails() async {
    setState(() {
      isLoaded = false;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .EventDetails(widget.id)
        .then((value) async {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    EventDetails();
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
      backgroundColor: COLOR_BACKGROUND,
      body: isLoaded == true
          ? NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 15),
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              expandedHeight: SizeConfig.screenWidth! / 1.5,
              collapsedHeight: 100,
              floating: true,
              pinned: true,

              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Stack(
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
                          image: (providerListener
                              .eventDetails!.mainImage ??
                              "") ==
                              ""
                              ? DecorationImage(
                            image: AssetImage(
                              "assets/ban1.jpg",
                            ),
                            fit: BoxFit.cover,
                          )
                              : DecorationImage(
                            image: NetworkImage((providerListener
                                .eventDetails!.mainImage ??
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
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenWidth! / 1.5,
                      decoration:
                      new BoxDecoration(color: Colors.transparent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              width: SizeConfig.screenWidth! / 1.3,
                              child: Text(
                                providerListener.eventDetails!.name ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                    letterSpacing: 1,
                                    decorationThickness: 1.5,
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 1),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Total prize: ",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        letterSpacing: 0.5,
                                        decorationThickness: 1.5,
                                        color: Color(0xff475464),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    currencySymbl +
                                        (providerListener.eventDetails!
                                            .price ??
                                            0)
                                            .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        letterSpacing: 0.5,
                                        decorationThickness: 1.5,
                                        color: Color(0xff475464),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff9DA6B1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .person_add_alt_1_outlined,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Share Event",
                                            style: GoogleFonts.montserrat(
                                                letterSpacing: 0,
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  LikeButton(
                                    size: 28,
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        isLiked
                                            ? Icons.favorite_rounded
                                            : Icons
                                            .favorite_border_rounded,
                                        color: isLiked
                                            ? Colors.red
                                            : Color(0xff475464),
                                        size: 28,
                                      );
                                    },
                                    circleColor: CircleColor(
                                        start: Color(0xffffffff),
                                        end: Color(0xffffffff)),
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Colors.red,
                                      dotSecondaryColor: COLOR_PURPLE,
                                    ),
                                  ),
                                ],
                              )
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
                                  color: Color(0xff475464),
                                ),
                              ),
                              SizedBox(width: 7),
                              Container(
                                width: SizeConfig.screenWidth! / 1.4,
                                child: Text(
                                  (providerListener
                                      .eventDetails!.ticketsSold)
                                      .toString() +
                                      "/" +
                                      (providerListener
                                          .eventDetails!.maxTickets)
                                          .toString() +
                                      " attending",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                      decoration:
                                      TextDecoration.underline,
                                      letterSpacing: 0.5,
                                      decorationThickness: 1.5,
                                      color: COLOR_PURPLE,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: SizeConfig.screenWidth! / 1.1,
                            child: Text(
                              "ABOUT:",
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 0.5,
                                  decorationThickness: 1.5,
                                  color: Color(0xff475464).withOpacity(1),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: SizeConfig.screenWidth! / 1.1,
                            child: Text(
                              (providerListener
                                  .eventDetails!.description ??
                                  "")
                                  .toString(),
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 1,
                                  decorationThickness: 1.5,
                                  color: Color(0xff475464),
                                  fontSize: 14.0,
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
                              "LOCATION:",
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 0.5,
                                  decorationThickness: 1.5,
                                  color: Color(0xff475464).withOpacity(1),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 18,
                                    child: Image.asset(
                                      'assets/location.png',
                                      fit: BoxFit.cover,
                                      color: Color(0xff475464),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Container(
                                    width: SizeConfig.screenWidth! / 2,
                                    child: Text(
                                      (providerListener.eventDetails!
                                          .location ??
                                          "")
                                          .toString(),
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 0.5,
                                          decorationThickness: 1.5,
                                          color: Color(0xff475464),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  if( Platform.isIOS){
                                    commonLaunchURL("maps://www.google.com/maps/dir/?api=1&travelmode=driving&layer=traffic&destination=18.5204,73.8567");
                                  }else{
                                    commonLaunchURL("https://www.google.com/maps/dir/?api=1&travelmode=driving&layer=traffic&destination=18.5204,73.8567");

                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: COLOR_PURPLE),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    child: Row(
                                      children: [

                                        Text(
                                          "Take me there",
                                          style: GoogleFonts.montserrat(
                                              letterSpacing: 0,
                                              color: COLOR_PURPLE,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                              "CONTACT:",
                              style: GoogleFonts.montserrat(
                                  letterSpacing: 0.5,
                                  decorationThickness: 1.5,
                                  color: Color(0xff475464).withOpacity(1),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth! / 1.5,
                                    child: Text(
                                      "Send us an email at",
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 0.5,
                                          decorationThickness: 1.5,
                                          color: Color(0xff475464),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final Email email = Email(
                                        body: 'Email body',
                                        subject: 'Email subject',
                                        recipients: [
                                          'contact@techalchemy.co'
                                        ],
                                        cc: ['contact@techalchemy.co'],
                                        bcc: ['contact@techalchemy.co'],
                                        isHTML: false,
                                      );

                                      await FlutterEmailSender.send(
                                          email);
                                    },
                                    child: Container(
                                      width:
                                      SizeConfig.screenWidth! / 1.5,
                                      child: Text(
                                        "contact@techalchemy.co",
                                        style: GoogleFonts.montserrat(
                                            letterSpacing: 0.5,
                                            decorationThickness: 1.5,
                                            color: COLOR_PURPLE,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth! / 2,
                                    child: Text(
                                      "call us at",
                                      style: GoogleFonts.montserrat(
                                          letterSpacing: 0.5,
                                          decorationThickness: 1.5,
                                          color: Color(0xff475464),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      commonLaunchURL(
                                          "tel:+1 991-681-0200");
                                    },
                                    child: Container(
                                      width:
                                      SizeConfig.screenWidth! / 1.5,
                                      child: Text(
                                        "+1 991-681-0200",
                                        style: GoogleFonts.montserrat(
                                            letterSpacing: 0.5,
                                            decorationThickness: 1.5,
                                            color: COLOR_PURPLE,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child:

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: AddToCartButton(
                    trolley: Icon(Icons.add_shopping_cart_outlined, color: Colors.white),
                    text: Text(
                      (currencySymbl +
                          (providerListener.eventDetails!.price ??
                              0)
                              .toString()) +
                          " - I'M IN!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          letterSpacing: 0.5,
                          decorationThickness: 1.5,
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    check: SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(24),
                    backgroundColor: COLOR_GREEN,
                    onPressed: (id) {
                      if (id == AddToCartButtonStateId.idle) {
                        //handle logic when pressed on idle state button.
                        setState(() {
                          stateId = AddToCartButtonStateId.loading;
                          setState(() {
                            stateId = AddToCartButtonStateId.done;
                          });
                          Provider.of<CustomViewModel>(context, listen: false)
                              .Purchase(widget.id, (providerListener.eventDetails!.price ??
                              0)
                              .toString())
                              .then((value) async {

                          });
                          pushReplacement(context, ConfirmedOrderScreen());
                        });
                      } else if (id == AddToCartButtonStateId.done) {
                        //handle logic when pressed on done state button.
                        setState(() {
                          stateId = AddToCartButtonStateId.idle;
                        });
                      }
                    },
                    stateId: stateId,
                  ),
                ),
              ),
            )
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
