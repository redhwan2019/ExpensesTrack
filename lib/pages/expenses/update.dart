import 'dart:io';
import 'package:excer/services/helper-service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'category.dart';

class UpdateExpense extends StatefulWidget {
  final Map current;
  UpdateExpense({this.current});

  @override
  _UpdateExpenseState createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  GlobalKey<FormState> keyform = GlobalKey<FormState>();

  TextEditingController amount = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController date = TextEditingController(
      text: HelperService().defaultDate(DateTime.now()).toString());
  String photo = "";
  bool autovalidate = false;
  Map chosenCategory;
  // DateTime d;

  initState() {
    super.initState();
    setState(() {
      amount.text = widget.current['amount'];
      category.text = widget.current['category']['name'];
      date.text = widget.current['date'];
      photo = widget.current['photo'];
      chosenCategory = widget.current['category'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create expense"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              confirmDelete(context);
            },
          )
        ],
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
                    hintStyle:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
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

  Future confirmDelete(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context2) {
          return AlertDialog(
            title: Text("Sure to delete ?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text("This Transction will be deleted ")],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Yes'.toUpperCase(),
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                ),
                onPressed: () {
                  Navigator.of(context2).pop();
                  Navigator.pop(context, "delete");
                },
              ),
              FlatButton(
                child: Text(
                  'no'.toUpperCase(),
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                ),
                onPressed: () {
                  Navigator.of(context2).pop();
                },
              )
            ],
          );
        });
  }
}
