import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yantra_live/common/helper.dart';

import 'package:yantra_live/common/my_colors.dart';
import 'package:yantra_live/common/size_config.dart';
import 'package:yantra_live/models/address_model.dart';
import 'package:yantra_live/presentation/screens/address_editing/address_editing.dart';
import 'package:yantra_live/providers/custom_view_model.dart';

import 'PdfViewerScreen.dart';
import 'enquiry_screen.dart';

class EnquiryListing extends StatefulWidget {
  const EnquiryListing({Key key}) : super(key: key);
  static const routeName = '/EnquiryListing';

  @override
  State<EnquiryListing> createState() => _EnquiryListingState();
}

class _EnquiryListingState extends State<EnquiryListing> {
  bool isLoaded = true;

  refresh() {
    setState(() {
      isLoaded = false;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .GetCartItems()
        .then((value) {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // refresh();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(
        FocusNode(),
      ),
      child: isLoaded
          ? Container(
              height: SizeConfig.screenHeight,
              child: Column(
                children: [
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            push(context, EnquiryScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: MyColors.primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)), //
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  providerListener.freeFlowList.length == 0
                      ? Container()
                      : Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "My Enquiries",
                                style: GoogleFonts.poppins(
                                  color: MyColors.secondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                  providerListener.freeFlowList.length == 0
                      ? Container()
                      : Container(
                          height: SizeConfig.screenHeight - 250,
                          child: ListView.builder(
                            itemCount: providerListener.freeFlowList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: SizeConfig.screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: const Offset(
                                        1.0,
                                        1.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 4.0,
                                    )
                                  ],
                                ),
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              providerListener
                                                          .freeFlowList[index]
                                                          .createdAt !=
                                                      null
                                                  ? (DateFormat.MMMd()
                                                          .format(DateTime.parse(
                                                              (providerListener.freeFlowList[index].createdAt ?? "")
                                                                  .toString()
                                                                  .replaceAll(
                                                                      "", "")))
                                                          .toString() +
                                                      "\n" +
                                                      DateFormat.jm()
                                                          .format(DateTime.parse(
                                                                  (providerListener.freeFlowList[index].createdAt ??
                                                                          "")
                                                                      .toString()
                                                                      .replaceAll(
                                                                          "", ""))
                                                              .toLocal())
                                                          .toString())
                                                  : "",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.yellow[800]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: SizeConfig.screenHeight * 0.12,
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig.screenWidth *
                                                  0.04),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.5,
                                                    child: Text(
                                                      (providerListener
                                                              .freeFlowList[
                                                                  index]
                                                              .freeFlowText ??
                                                          ""),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  (providerListener
                                                                  .freeFlowList[
                                                                      index]
                                                                  .title ??
                                                              "") ==
                                                          (providerListener
                                                                  .freeFlowList[
                                                                      index]
                                                                  .freeFlowText ??
                                                              "")
                                                      ? Container()
                                                      : Container(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.5,
                                                          child: Text(
                                                            (providerListener
                                                                    .freeFlowList[
                                                                        index]
                                                                    .title ??
                                                                ""),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                  Text(
                                                    "Status: " +
                                                        (providerListener
                                                                .freeFlowList[
                                                                    index]
                                                                .status ??
                                                            "No Updates"),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      (providerListener.freeFlowList[index]
                                                      .status ??
                                                  "") ==
                                              "QUOTED"
                                          ? Expanded(
                                              flex: 2,
                                              child: InkWell(
                                                onTap: () {
                                                  EasyLoading.show(
                                                      status: 'Please wait...');
                                                  Provider.of<CustomViewModel>(
                                                          context,
                                                          listen: false)
                                                      .getPDF(providerListener
                                                          .freeFlowList[index]
                                                          .id)
                                                      .then((value) {
                                                    EasyLoading.dismiss();
                                                    setState(() {
                                                      if (value != null) {
                                                        push(
                                                            context,
                                                            PdfViewerScreen(
                                                                value ?? "",
                                                                providerListener
                                                                        .freeFlowList[
                                                                            index]
                                                                        .id ??
                                                                    ""));
                                                        //  commonLaunchURL(value ?? "");
                                                      } else {
                                                        commonToast(context,
                                                            "Quotation not generated as of now");
                                                      }
                                                    });
                                                  });
                                                },
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: SizeConfig
                                                                .screenWidth *
                                                            0.04),
                                                    child: const Icon(
                                                        Icons.picture_as_pdf,
                                                        color: Colors.red,
                                                        size: 40)),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }
}
