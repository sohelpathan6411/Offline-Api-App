import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:tic_tac_toe/Helpers/constants.dart';
import 'package:tic_tac_toe/Helpers/helper.dart';
import 'package:tic_tac_toe/Helpers/size_config.dart';
import 'package:tic_tac_toe/View%20Models/CustomViewModel.dart';

List<File> selectedImageList = [];

class AddPostScreen extends StatefulWidget {


  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: white,
                      size: 22,
                    ),
                  ),
                ),
                Text(
                  "Add Posts",
                  textScaleFactor: 1,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 50)
              ],
            ),
          ),
        ),
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 3,
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 5,
                  controller: bodyController,
                  decoration: const InputDecoration(
                    hintText: 'Body',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CustomViewModel>(context, listen: false)
                          .addPost(1, titleController.text,
                              bodyController.text)
                          .then((value) {
                        setState(() {
                          pop(context);
                        });
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        primary.withOpacity(0.8),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(8),
                      ),
                    ),
                    // color: MyColors.primary,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        "Save",
                        textScaleFactor: 1,
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
