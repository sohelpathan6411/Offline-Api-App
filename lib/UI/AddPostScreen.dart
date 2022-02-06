import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:provider/provider.dart';

import 'package:yantra_live/common/asset_path.dart';
import 'package:yantra_live/common/constants.dart';
import 'package:yantra_live/common/helper.dart';
import 'package:yantra_live/common/my_colors.dart';
import 'package:http/http.dart' as http;
import 'package:yantra_live/common/size_config.dart';
import 'package:yantra_live/models/enquiry_model.dart';
import 'package:yantra_live/presentation/screens/home_screen/home_screen.dart';
import 'package:yantra_live/presentation/screens/my_page_view/my_page_view.dart';
import 'package:yantra_live/providers/custom_view_model.dart';

List<File> selectedImageList = [];

class EnquiryScreen extends StatefulWidget {
  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  TextEditingController descController = new TextEditingController();

  var selectedBrand, selectedModel, selectedCategory, selectedSubCategory;

  Future<void> getBrandsFreeFlow() async {
    print("aaaaaaaaaaaaaa");

    setState(() {
      EasyLoading.show(status: 'Please wait...');
    });
    Provider.of<CustomViewModel>(context, listen: false)
        .getBrandsFreeFlow()
        .then((value) {
      EasyLoading.dismiss();
    });
  }

  Future getImageAttachments() async {
    try {
      List<Media> _listImagePaths = await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          selectCount: 1,
          showGif: false,
          showCamera: true,
          compressSize: 500,
          uiConfig: UIConfig(uiThemeColor: MyColors.primary),
          cropConfig: CropConfig(enableCrop: true));

      _listImagePaths.forEach((media) {
        setState(() {
          selectedImageList.add(File(media.path));
        });
      });
    } on PlatformException {}
  }

  Future editImageAttachments(index) async {
    try {
      List<Media> _listImagePaths = await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          selectCount: 1,
          showGif: false,
          showCamera: true,
          compressSize: 500,
          uiConfig: UIConfig(uiThemeColor: MyColors.primary),
          cropConfig: CropConfig(enableCrop: true));

      _listImagePaths.forEach((media) {
        setState(() {
          selectedImageList[index] = File(media.path);
        });
      });
    } on PlatformException {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedImageList.clear();
    });
    getBrandsFreeFlow();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        title: const Text(
          'Add Enquiry',
          style: TextStyle(color: MyColors.secondary),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(
          color: MyColors.secondary,
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: " Send us an",
                          style: TextStyle(
                            color: MyColors.secondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: " Enquiry now",
                          style: GoogleFonts.poppins(
                            color: MyColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.image_outlined,
                              color: MyColors.secondary, size: 30),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Images",
                            style: GoogleFonts.poppins(
                              color: MyColors.secondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getImageAttachments();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            color: MyColors.primary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)), //
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                selectedImageList.isEmpty
                    ? Container()
                    : Container(
                        height: 140,
                        width: SizeConfig.screenWidth,
                        child: ListView.builder(
                            itemCount: selectedImageList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: selectedImageList[
                                                            index] ==
                                                        null
                                                    ? const AssetImage(
                                                        'assets/images/notfound.png')
                                                    : FileImage(
                                                        selectedImageList[
                                                            index]),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              /* InkWell(
                                                onTap: () {
                                                  editImageAttachments(index);
                                                },
                                                child: Container(
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                  ),
                                                ),
                                              ),*/
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedImageList.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        child: const Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                selectedBrand != null
                    ? Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade600),
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)), //
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedBrand,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    providerListener.modelsList.clear();
                                    providerListener.categoryList.clear();
                                    providerListener.subcategoryList.clear();
                                    selectedBrand = null;
                                    selectedModel = null;
                                    selectedCategory = null;
                                    selectedSubCategory = null;
                                  });
                                },
                                child: Icon(Icons.close))
                          ],
                        ),
                      )
                    : DropdownSearch(
                        showSearchBox: true,
                        scrollbarProps: ScrollbarProps(
                            isAlwaysShown: true,
                            thickness: 8,
                            interactive: true,
                            showTrackOnHover: true),
                        popupTitle: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select Brands',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        dropdownSearchDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(4.0),
                          labelText: 'Select Brands',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        items: providerListener.brandsList,
                        onChanged: (value) {
                          setState(() {
                            selectedBrand = value;
                            providerListener.modelsList.clear();
                            EasyLoading.show(status: 'Please wait...');
                            providerListener
                                .getModelsFreeFlow(selectedBrand)
                                .then((value) {
                              EasyLoading.dismiss();
                            });
                          });
                        },
                        popupItemBuilder: (context, String str, b) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  str,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                const SizedBox(
                  height: 20,
                ),
                providerListener.modelsList.length == 0
                    ? Container()
                    : selectedModel != null
                        ? Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)), //
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedModel,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        providerListener.categoryList.clear();
                                        providerListener.subcategoryList
                                            .clear();
                                        selectedModel = null;
                                        selectedCategory = null;
                                        selectedSubCategory = null;
                                      });
                                    },
                                    child: const Icon(Icons.close))
                              ],
                            ),
                          )
                        : DropdownSearch(
                            showSearchBox: true,
                            scrollbarProps: ScrollbarProps(
                                isAlwaysShown: true,
                                thickness: 8,
                                interactive: true,
                                showTrackOnHover: true),
                            popupTitle: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Models',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(4.0),
                              labelText: 'Select Models',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            items: providerListener.modelsList,
                            onChanged: (value) {
                              setState(() {
                                selectedModel = value;
                                int idx =
                                    providerListener.modelsList.indexOf(value);

                                EasyLoading.show(status: 'Please wait...');
                                providerListener
                                    .getCategoriesFreeFlow(
                                        selectedBrand, selectedModel, idx)
                                    .then((value) {
                                  EasyLoading.dismiss();
                                });
                              });
                            },
                            popupItemBuilder: (context, String str, b) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      str,
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                const SizedBox(
                  height: 20,
                ),
                providerListener.categoryList.length == 0
                    ? Container()
                    : selectedCategory != null
                        ? Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)), //
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedCategory,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        providerListener.subcategoryList
                                            .clear();
                                        selectedCategory = null;
                                        selectedSubCategory = null;
                                      });
                                    },
                                    child: const Icon(Icons.close))
                              ],
                            ),
                          )
                        : DropdownSearch(
                            showSearchBox: true,
                            scrollbarProps: ScrollbarProps(
                                isAlwaysShown: true,
                                thickness: 8,
                                interactive: true,
                                showTrackOnHover: true),
                            popupTitle: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Category',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(4.0),
                              labelText: 'Select Category',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            items: providerListener.categoryList,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;

                                EasyLoading.show(status: 'Please wait...');
                                providerListener
                                    .getSubCategoriesFreeFlow(selectedBrand,
                                        selectedModel, selectedCategory)
                                    .then((value) {
                                  EasyLoading.dismiss();
                                });
                              });
                            },
                            popupItemBuilder: (context, String str, b) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      str,
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                const SizedBox(
                  height: 20,
                ),
                providerListener.subcategoryList.length == 0
                    ? Container()
                    : selectedSubCategory != null
                        ? Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.all(
                                  const Radius.circular(5.0)), //
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedSubCategory,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedSubCategory = null;
                                      });
                                    },
                                    child: const Icon(Icons.close))
                              ],
                            ),
                          )
                        : DropdownSearch(
                            showSearchBox: true,
                            scrollbarProps: ScrollbarProps(
                                isAlwaysShown: true,
                                thickness: 8,
                                interactive: true,
                                showTrackOnHover: true),
                            popupTitle: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Select Subcategory',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(4.0),
                              labelText: 'Select Subcategory',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            items: providerListener.subcategoryList,
                            onChanged: (value) {
                              setState(() {
                                selectedSubCategory = value;
                              });
                            },
                            popupItemBuilder: (context, String str, b) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      str,
                                      style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 5,
                  controller: descController,
                  decoration: const InputDecoration(
                    hintText: 'Tell Us More',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  cursorColor: Colors.black,
                  style: const TextStyle(
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
                      if (selectedBrand != null) {
                        //addEnquiry
                        EasyLoading.show(status: 'Submitting...');
                        Provider.of<CustomViewModel>(context, listen: false)
                            .addEnquiry(
                                (descController.text.isEmpty
                                    ? ""
                                    : descController.text),
                                (selectedBrand ?? "") +
                                    " " +
                                    (selectedModel ?? "") +
                                    " " +
                                    (selectedCategory ?? "") +
                                    " " +
                                    (selectedSubCategory ?? ""))
                            .then((value) async {
                          if (value != "error") {
                            try {
                              if (selectedImageList.isNotEmpty) {
                                for (int i = 0;
                                    i < selectedImageList.length;
                                    i++) {
                                  await Provider.of<CustomViewModel>(context,
                                          listen: false)
                                      .uploadAttachment(
                                          value, selectedImageList[i])
                                      .then((value) {
                                    return null;
                                  });
                                }
                              }
                            } catch (e) {
                              // ignore: avoid_print
                              print(e);
                            }

                            Provider.of<CustomViewModel>(context, listen: false)
                                .GetCartItems()
                                .then((value) {
                              setState(() {
                                EasyLoading.dismiss();
                                pop(context);
                              });
                            });
                          } else {
                            commonToast(
                                context, "Something went wrong, try again!");
                          }
                        });
                      } else {
                        commonToast(context, "Select brand at least");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        MyColors.primary,
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(4.0),
                      ),
                    ),
                    // color: MyColors.primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        "Submit Enquiry",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
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

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    Key key,
    this.popupTitle,
    this.items,
    this.imagePath,
    this.hintText,
  }) : super(key: key);
  final String popupTitle;
  final List<String> items;
  final String imagePath;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      popupTitle: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            popupTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      dropdownSearchDecoration: InputDecoration(
        contentPadding: const EdgeInsets.all(4.0),
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      items: items,
      popupItemBuilder: (context, String str, b) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                str,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
