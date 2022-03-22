import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:tic_tac_toe/Helpers/constants.dart';
import 'package:tic_tac_toe/Helpers/helper.dart';

class WebService {
  Future AllEvents() async {
    try {
      final response = await http.get(
        Uri.parse(allEvents),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + bearerToken,
        },
      );

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


  Future EventDetails(id) async {
    try {
      final response = await http.get(
        Uri.parse(eventDetails + "/" + id.toString()),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ' + bearerToken,
        },
      );

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

  Future Purchase(eventId, purchaseAmount) async {
    try {
      final response = await http.post(
          Uri.parse(purchase),
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer ' + bearerToken,
          },
          body: json.encode({
            "purchase": {
              "dateTime": "2/13/2021 16:00:00",
              "purchaseAmount": purchaseAmount.toString(),
              "paymentMethodType": "visa",
              "eventId": eventId.toString()
            }
          }),
      );

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
