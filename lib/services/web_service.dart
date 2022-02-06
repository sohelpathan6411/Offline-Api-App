import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:tic_tac_toe/Helpers/constants.dart';

class WebService {
  Future getAllPosts() async {
    try {
      final response = await http.get(Uri.parse(getallposts));

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
      return "error";
    }
  }
}
