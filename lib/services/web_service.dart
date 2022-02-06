import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:payroll/Helpers/constants.dart';

class WebService {
  Future sendOtp(mobileno) async {
    try {
      Map body = {"mobileno": mobileno};

      final response = await http.post(Uri.parse(sendotp), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future verifyOtp(mobileno, otp) async {
    try {
      Map body = {"mobileno": mobileno, "otp": otp};

      final response = await http.post(Uri.parse(verifyotp), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future registerUser(
      firstname,
      lastname,
      emails,
      phone,
      latitude,
      longtitude,
      state,
      district,
      fcmtoken,
      companyname,
      department,
      File profile_image) async {
    try {
      var uri = Uri.parse(registeruser);
      var request = new http.MultipartRequest("POST", uri);

      if (profile_image != null) {
        var _bannerFront =
            new http.ByteStream(Stream.castFrom(profile_image.openRead()));
        var _bannerLength = await profile_image.length();

        var multipartBannerFront = new http.MultipartFile(
            "profile_image", _bannerFront, _bannerLength,
            filename: basename(profile_image.path));
        request.files.add(multipartBannerFront);
      }

      request.fields['firstname'] = firstname;
      request.fields['lastname'] = lastname;
      request.fields['emails'] = emails;
      request.fields['phone'] = phone;
      request.fields['latitude'] = latitude;
      request.fields['longtitude'] = longtitude;
      request.fields['state'] = state;
      request.fields['district'] = district;
      request.fields['fcmtoken'] = fcmtoken;
      request.fields['companyname'] = companyname;
      request.fields['department'] = department;

      var response = await request.send();
      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getProfile(userid, fcmtoken) async {
    try {
      Map body = {
        "userid": userid,
        "fcmtoken": fcmtoken,
        "platform": (Platform.isAndroid ? "android" : "ios")
      };

      final response = await http.post(Uri.parse(getprofile), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getallCategories() async {
    try {
      final response = await http.post(Uri.parse(getallcategories));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getSubcategoriesbycatid(categoryid) async {
    try {
      Map body = {"categoryid": categoryid};

      final response =
          await http.post(Uri.parse(getsubcategoriesbycatid), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getAllproducts() async {
    try {
      final response = await http.post(Uri.parse(getallproducts));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getAllbrands() async {
    try {
      final response = await http.post(Uri.parse(getallexhibitors));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getAlladvertisement() async {
    try {
      final response = await http.post(Uri.parse(getalladvertisement));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getAllnotifications() async {
    try {
      final response = await http.post(Uri.parse(getallnotifications));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getProductsbyid(productsid, userid) async {
    try {
      Map body = {"productsid": productsid, "userid": userid};

      final response = await http.post(Uri.parse(getproductsbyid), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getBrandsbyid(brandids, userid) async {
    try {
      Map body = {"exhibitorsids": brandids, "userid": userid};

      final response =
          await http.post(Uri.parse(getexhibitorsbyid), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getDetailsbysubcategoryid(subcategoryids) async {
    try {
      Map body = {"subcategoryids": subcategoryids};

      final response =
          await http.post(Uri.parse(getdetailsbysubcategoryid), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getUniversalsearch(searchkeywords) async {
    try {
      Map body = {"filtersearch": searchkeywords};

      final response =
          await http.post(Uri.parse(getuniversalsearch), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getFeaturedproducts() async {
    try {
      final response = await http.post(Uri.parse(getallfeaturedproducts));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getFeaturedbrands() async {
    try {
      final response = await http.post(Uri.parse(getallfeaturedexhibitors));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future submitQuery(userid, subject, desc, qty) async {
    try {
      Map body = {
        "userid": userid,
        "subjects": subject,
        "descriptions": desc,
        "quantity": qty
      };

      final response = await http.post(Uri.parse(submitquery), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getAppVersion() async {
    try {
      final response = await http.get(
        Uri.parse(appversion),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future likeDislikesproducts(
      userid, productid, productslikedislike, type) async {
    try {
      Map body = {
        "userid": userid,
        "productid": productid,
        "productslikedislike": productslikedislike,
        "types": type
      };

      print(body);

      final response =
          await http.post(Uri.parse(likedislikesproducts), body: body);
      print(response.body);
      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getLikesdislikesproducts(userid) async {
    try {
      Map body = {"userid": userid};

      final response =
          await http.post(Uri.parse(getlikesdislikesproducts), body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }
}
