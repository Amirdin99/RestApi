import 'dart:async';

import 'package:flutterapi/repository/trainer_repository.dart';
import 'package:flutterapi/response/models/TrainerJson.dart';

class TrainerStream{

  var trainerrepositroy=TrainerRepository();
  final _stateStreamController=StreamController<List<TrainerJson>>();
  StreamSink<List<TrainerJson>> get trainerSink =>_stateStreamController.sink;
  Stream<List<TrainerJson>> get trainerStream =>_stateStreamController.stream;

}

var trainerStream=TrainerStream();