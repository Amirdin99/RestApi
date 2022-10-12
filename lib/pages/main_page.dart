import 'package:flutter/material.dart';
import 'package:flutterapi/response/models/TrainerJson.dart';
import 'package:flutterapi/stream/trainer_stream.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

import 'my_list_item.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _nameTextField = TextEditingController();
  TextEditingController _surnameTextField = TextEditingController();
  TextEditingController _salaryTextField = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllModels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showAddDialog(context);
        },
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
      body: Container(
          child: StreamBuilder<List<TrainerJson>>(
        stream: trainerStream.trainerStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if (snapshot.data!.length == 0) {
            //   return error(snapshot.error.toString());
            // }
            return ListView.builder(
              itemCount: 1000,
              itemBuilder: (BuildContext context, int index) {
                return MyListItem(snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return error(snapshot.error.toString());
          } else {
            return loading();
          }
        },
      )),
    );
  }

  void getAllModels() {
    trainerStream.trainerrepositroy
        .getAllData()
        .then((trainerModel) => trainerStream.trainerSink.add(trainerModel));
  }

  Widget error(String error) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 24),
          ),
          ElevatedButton(
              onPressed: () {
                trainerStream.trainerrepositroy.getAllData().then(
                    (trainerModel) =>
                        trainerStream.trainerSink.add(trainerModel));
              },
              child: Text("Try again"))
        ],
      ),
    );
  }

  Widget loading() {
    return Loading(
      indicator: BallSpinFadeLoaderIndicator(),
      size: 150.0,
      color: Colors.blue,
    );
  }

  void showAddDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add dialog"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Are you sure?"),
                  TextField(
                    controller: _nameTextField..text = " ",
                    decoration: InputDecoration(
                      hintText: "Please enter the name",
                    ),
                  ),
                  TextField(
                    controller: _surnameTextField..text = " ",
                    decoration: InputDecoration(
                      hintText: "Please enter the surname",
                    ),
                  ),
                  TextField(
                    controller: _salaryTextField..text = " ",
                    decoration: InputDecoration(
                      hintText: "Please enter the salary",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("no")),
              ElevatedButton(
                onPressed: () {
                  trainerStream.trainerrepositroy
                      .updateData(TrainerJson(
                          name: _nameTextField.text.toString(),
                          surname: _surnameTextField.text.toString(),
                          salary:
                              _salaryTextField.text.toString()))
                      .then((value) => trainerStream.trainerrepositroy
                          .getAllData()
                          .then((trainerList) =>
                              trainerStream.trainerSink.add(trainerList)));
                  Navigator.of(context).pop();
                },
                child: Text("yes"),
              )
            ],
          );
        });
  }
}
