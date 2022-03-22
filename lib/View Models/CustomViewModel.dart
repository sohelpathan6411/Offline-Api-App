import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Models/EventDetailsParser.dart';
import 'package:tic_tac_toe/Models/EventsLIstParser.dart';
import 'package:tic_tac_toe/services/web_service.dart';

class CustomViewModel extends ChangeNotifier {
  List<EventsLIstParser> eventsList = [];
  List<EventsLIstParser> recommendedEventsList = [];

  EventDetailsParser? eventDetails;

  Future AllEvents() async {
    eventsList.clear();
    recommendedEventsList.clear();

    final response = await WebService().AllEvents();

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      int eventCounter = 0;
      int recEventCounter = 0;

      for (Map i in responseDecoded['allEvents']) {
        var tempDate = "";

        if (EventsLIstParser.fromJson(i).dateTime != null) {
          tempDate = EventsLIstParser.fromJson(i).dateTime;
          if (tempDate.isNotEmpty) {
            tempDate = tempDate
                    .toString()
                    .split(" ")
                    .first
                    .split('/')
                    .reversed
                    .join('-') +
                " " +
                (tempDate.toString().split(" ").last);
            if (tempDate.toString().length < 19) {
              List<String> asd =
                  tempDate.toString().split(" ").first.split('-');

              print(asd[2]);
              if (asd[2].length == 1) {
                print("aaaaaaaaaaaaaaaaaaaaa");
                asd[2] = "0" + asd[2];
              }
              if (asd[1].length == 1) {
                asd[1] = "0" + asd[1];
              }
              tempDate =
                  asd.join("-") + " " + (tempDate.toString().split(" ").last);
            }
          }
        }

        eventsList.add(EventsLIstParser.fromJson(i));

        eventsList[eventCounter].dateTime = tempDate;
        print(eventsList[eventCounter].dateTime);
        eventCounter++;
        if ((EventsLIstParser.fromJson(i).isRecommended ?? false) == true) {
          recommendedEventsList.add(EventsLIstParser.fromJson(i));

          recommendedEventsList[recEventCounter].dateTime = tempDate;
          recEventCounter++;
        }
      }
      notifyListeners();
      return "success";
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future EventDetails(id) async {
    eventDetails = null;

    final response = await WebService().EventDetails(id);

    if (response != "error" && response != null) {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      eventDetails =
          EventDetailsParser.fromJson(responseDecoded['eventDetail']);

      print(responseDecoded['eventDetail']);

      notifyListeners();
      return "success";
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future Purchase(eventId, purchaseAmount) async {


    final response = await WebService().Purchase(eventId, purchaseAmount);

    if (response != "error" && response != null) {
      notifyListeners();
      return "success";
    } else {
      notifyListeners();
      return "error";
    }
  }
}
