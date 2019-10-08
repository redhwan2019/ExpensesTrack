import 'dart:io';
import 'package:excer/services/helper-service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'category.dart';

class CreateExpensesPage extends StatefulWidget {
  @override
  _CreateExpensesPageState createState() => _CreateExpensesPageState();
}

class _CreateExpensesPageState extends State<CreateExpensesPage> {
  GlobalKey<FormState> keyform = GlobalKey<FormState>();

  TextEditingController amount = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController date = TextEditingController(
      text: HelperService().defaultDate(DateTime.now()).toString());
  String photo = "";
  bool autovalidate = false;
  Map chosenCategory;
  // DateTime d;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create expense"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: keyform,
          autovalidate: autovalidate,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: amount,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.money_off),
                  hintText: "0",
                  hintStyle: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)
                ),
                keyboardType: TextInputType.number,
                autofocus: true,
                validator: (String value) {
                  if (value.isEmpty || double.parse(value) < 0) {
                    return "please enter amount";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: category,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.star),
                  hintText: "Select category",
                ),
                readOnly: true,
                onTap: () {
                  goToCategoryPage();
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return "please select category";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: date,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  hintText: "Select date",
                ),
                keyboardType: TextInputType.text,
                readOnly: true,
                onTap: () {
                  datePicker(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              pickPhoto(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Save".toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    if (keyform.currentState.validate()) {
                      Map form = {
                        'amount': amount.text,
                        'category': chosenCategory,
                        'date': date.text,
                        'photo': photo,
                      };
                      Navigator.pop(context, form);
                    } else {
                      setState(() {
                        autovalidate = true;
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pickPhoto() {
    if (photo.isEmpty) {
      return Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 120,
              child: FlatButton(
                color: Color.fromRGBO(230, 230, 230, 0.5),
                child: Icon(Icons.camera_alt),
                onPressed: () {
                  return takePhoto(ImageSource.camera);
                },
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: SizedBox(
              height: 120,
              child: FlatButton(
                color: Color.fromRGBO(230, 230, 230, 0.5),
                child: Icon(Icons.photo_library),
                onPressed: () {
                  return takePhoto(ImageSource.gallery);
                },
              ),
            ),
          )
        ],
      );
    } else {
      return Image.asset(
        photo,
        width: double.infinity,
        height: 120,
        fit: BoxFit.cover,
      );
    }
  }

  void takePhoto(ImageSource imgSource) async {
    File file = await ImagePicker.pickImage(source: imgSource);
    if (file != null) {
      setState(() {
        photo = file.path;
      });
    }
  }

  void datePicker(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2011, 3, 5),
        maxTime: DateTime(2019, 10, 4), onConfirm: (date) {
      setState(() {
        this.date.text = HelperService().defaultDate(date);
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void goToCategoryPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Category(),
      ),
    );

    if (result != null) {
      setState(() {
        this.category.text = result['name'];
        chosenCategory = result;
      });
    }
  }
}
