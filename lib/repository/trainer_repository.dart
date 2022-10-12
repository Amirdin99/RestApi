import 'dart:convert';

import 'package:flutterapi/response/models/TrainerJson.dart';
import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_middleware.dart';

class TrainerRepository {
  String BASE_URL = "https://633ea7f583f50e9ba3b535eb.mockapi.io";
  static const headers={"Content-Type":"application/json"};

//get
  Future<List<TrainerJson>> getAllData() async {

    HttpWithMiddleware httplCient = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.HEADERS),
      HttpLogger(logLevel: LogLevel.BODY),
    ]);


      var response = await httplCient.get("$BASE_URL/trainers",);
      if (response.statusCode == 200) {
        var listFromJson = TrainerJson.listFromJson(jsonDecode(response.body));
        print("ishladi$listFromJson");
        return listFromJson;

      } else {
        return [];
      }
    //  catch (exception) {
    //   print("No internet connection$exception");
    //   return [];
    // }
  }

  //post
  Future<TrainerJson> updateData(TrainerJson model) async {
    HttpWithMiddleware httplCient = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.HEADERS),
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      var response = await httplCient.post("$BASE_URL/trainers",
          body: json.encode(model.toJson()),headers: headers);
      if (response.statusCode == 200) {
        var listFromJson = TrainerJson.fromJson(json.decode(response.body));
        return listFromJson;
      } else {
        return TrainerJson(
             name: 'Amirdin', surname: 'Ismoilov', salary: "32000");;
      }
    } catch (exception) {
      return TrainerJson(
           name: 'Amirdin', surname: 'Ismoilov', salary: "32000");

    }
  }

  //put
  Future<TrainerJson> putData(TrainerJson model) async {
    HttpWithMiddleware httplCient = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.HEADERS),
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      var response = await httplCient.put("$BASE_URL/trainers/${model.id}",
          body: json.encode(model.toJson()),headers: headers);
      if (response.statusCode == 200) {
        var listFromJson = TrainerJson.fromJson(json.decode(response.body));
        return listFromJson;
      } else {
        return TrainerJson(
             name: 'Amirdin', surname: 'Ismoilov', salary: "32000");
      }
    } catch (exception) {
      return TrainerJson(
           name: 'Amirdin', surname: 'Ismoilov', salary: "32000");

    }
  }
  //delete

  Future deleteModelData(int id) async {
    HttpWithMiddleware httplCient = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.HEADERS),
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      var response = await httplCient.delete("$BASE_URL/trainers/${id}",headers: headers);
      if (response.statusCode == 200) {
        var listFromJson = TrainerJson.fromJson(json.decode(response.body));
        return listFromJson;
      } else {
        return TrainerJson(
             name: 'Amirdin', surname: 'Ismoilov', salary: "32000");
      }
    } catch (exception) {
      return TrainerJson(
           name: 'Amirdin', surname: 'Ismoilov', salary: "32000");
    }
  }
}
