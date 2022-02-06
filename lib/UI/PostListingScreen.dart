import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/Helpers/DBProvider.dart';
import 'package:tic_tac_toe/Helpers/constants.dart';
import 'package:tic_tac_toe/Helpers/helper.dart';
import 'package:tic_tac_toe/Helpers/size_config.dart';
import 'package:tic_tac_toe/Models/PostListParser.dart';
import 'package:tic_tac_toe/View%20Models/CustomViewModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'AddPostScreen.dart';

class PostListingScreen extends StatefulWidget {
  const PostListingScreen({Key? key}) : super(key: key);

  @override
  State<PostListingScreen> createState() => _PostListingScreenState();
}

class _PostListingScreenState extends State<PostListingScreen> {
  bool isLoaded = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  refresh() async {
    setState(() {
      isLoaded = false;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      getAllPosts();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      getAllPosts();
    } else {
      Provider.of<CustomViewModel>(context, listen: false)
          .getFromLocal()
          .then((value) {
        setState(() {
          isLoaded = true;
        });
      });
    }
  }

  getAllPosts() async {
    setState(() {
      isLoaded = false;
    });

    await DBProvider.db.getAllPosts().then((result) {
      if (result.isNotEmpty) {
        // if already exists in local
        Provider.of<CustomViewModel>(context, listen: false)
            .getFromLocal()
            .then((value) {
          setState(() {
            isLoaded = true;
          });
        });
      } else {
        Provider.of<CustomViewModel>(context, listen: false)
            .getAllPosts()
            .then((value) async {
          setState(() {
            isLoaded = true;
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF672024), // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icon color
      systemNavigationBarIconBrightness:
          Brightness.light, // color of navigation controls
    ));
    refresh();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: redGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Posts (" +
                      (providerListener.postList.length.toString()) +
                      ")",
                  textScaleFactor: 1,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondary,
        splashColor: primary,
        onPressed: () {
          push(context, AddPostScreen());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: isLoaded == true
          ? Container(
              padding: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.05,
                  image: AssetImage(
                    "assets/bg.png",
                  ),
                ),
                gradient: LinearGradient(
                    colors: whiteGradient,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              height: SizeConfig.screenHeight! - 30,
              child: providerListener.postList.length == 0
                  ? Container()
                  : Scrollbar(
                      interactive: true,
                      radius: const Radius.circular(20),
                      thickness: 10,
                      child: ListView.builder(
                        itemCount: providerListener.postList.length + 1,
                        itemBuilder: (context, index) {
                          return providerListener.postList.length == index
                              ? Container(height: 200)
                              : Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  secondaryActions: [
                                    IconSlideAction(
                                      caption: 'Archive',
                                      color: Colors.red,
                                      icon: Icons.archive,
                                      onTap: () {
                                        Provider.of<CustomViewModel>(context,
                                                listen: false)
                                            .deletePost(
                                                index,
                                                providerListener
                                                    .postList[index].id)
                                            .then((value) async {
                                          /*await storage.setItem("posts",
                              json.encode(providerListener.postList));*/
                                        });
                                      },
                                    ),
                                  ],
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: whiteGradient,
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 3),
                                                child: Container(
                                                  width:
                                                      SizeConfig.screenWidth! /
                                                          1.2,
                                                  child: Text(
                                                    ((index + 1).toString()) +
                                                        ". " +
                                                        (providerListener
                                                                .postList[index]
                                                                .title ??
                                                            ""),
                                                    style: GoogleFonts.openSans(
                                                        letterSpacing: 0.7,
                                                        color: Colors.black,
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 5),
                                                width: SizeConfig.screenWidth! /
                                                    1.2,
                                                child: Text(
                                                  providerListener
                                                          .postList[index]
                                                          .title ??
                                                      "",
                                                  style: GoogleFonts.openSans(
                                                      letterSpacing: 0.7,
                                                      color: Colors.black,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
            )
          : SizedBox(
              height: SizeConfig.screenHeight! - 30,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: secondary,
                  valueColor: AlwaysStoppedAnimation<Color>(primary),
                ),
              ),
            ),
    );
  }
}
