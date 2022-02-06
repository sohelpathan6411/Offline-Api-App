import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Helpers/DBProvider.dart';
import 'package:tic_tac_toe/Models/PostListParser.dart';
import 'package:tic_tac_toe/services/web_service.dart';

class CustomViewModel extends ChangeNotifier {
  List<PostListParser> postList = [];

  Future getAllPosts() async {
    postList.clear();

    final response = await WebService().getAllPosts();

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      for (Map i in responseDecoded) {
        postList.add(PostListParser.fromJson(i));
        DBProvider.db.createPosts(PostListParser.fromJson(i));
      }
      notifyListeners();
      return "success";
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getFromLocal() async {
    postList.clear();

    await DBProvider.db.getAllPosts().then((result) {
      postList = result;
    });

    notifyListeners();
    return "success";
  }

  Future deletePost(index, id) async {


    await DBProvider.db.deletePost(id);
    postList.removeAt(index);
    notifyListeners();
    return "success";
  }

  Future addPost(userId, title, body) async {
    int? id = 0;
    id = postList[postList.length-1].id;

    postList.add(PostListParser(userId, id! + 1, title, body));
    DBProvider.db.addPosts(PostListParser(userId, id + 1, title, body));

    notifyListeners();
    return "success";
  }
}
