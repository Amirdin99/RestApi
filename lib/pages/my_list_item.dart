import 'package:flutter/material.dart';
import 'package:flutterapi/response/models/TrainerJson.dart';

import '../stream/trainer_stream.dart';

class MyListItem extends StatelessWidget {
  late TrainerJson model;

  MyListItem(this.model);

  TextEditingController _nameTextField = TextEditingController();
  TextEditingController _surnameTextField = TextEditingController();
  TextEditingController _salaryTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        margin: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    model.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    model.surname,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: GestureDetector(
                      onTap: () {
                        showEditingDialog(context, model);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.green,
                        size: 18,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: GestureDetector(
                      onTap: () {
                        trainerStream.trainerrepositroy
                            .deleteModelData(int.parse(model.id!))
                            .then((value) => trainerStream.trainerrepositroy
                                .getAllData()
                                .then((trainerList) => trainerStream.trainerSink
                                    .add(trainerList)));
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 18,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showEditingDialog(BuildContext context, TrainerJson model) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("are you sure!"),
                  TextField(
                    controller: _nameTextField..text = model.name,
                    decoration: InputDecoration(hintText: "Enter your name"),
                  ),
                  TextField(
                    controller: _surnameTextField..text = model.surname,
                    decoration: InputDecoration(hintText: "Enter your surname"),
                  ),
                  TextField(
                    controller: _salaryTextField..text = model.salary,
                    decoration: InputDecoration(hintText: "Enter your salary"),
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
                      .putData(TrainerJson(
                          id: model.id,
                          name: _nameTextField.text.toString(),
                          surname: _surnameTextField.text.toString(),
                          salary: _salaryTextField.text.toString()))
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
