import 'package:excer/pages/expenses/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

const biggerFont = TextStyle(fontWeight: FontWeight.w400);

class _LoginPageState extends State<LoginPage> {
  @override
  TextEditingController user = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Stack(
          children: <Widget>[
            backgroundLayer(),
            mainLayer(context),
          ],
        ));
  }

  Widget backgroundLayer() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.lightGreen,
            Colors.green,
          ])),
    );
  }

  Widget mainLayer(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/icons/logo.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome To",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Expense Tracker",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            inputUserName(),
            SizedBox(
              height: 20,
            ),
            submitBtn(),
          ],
        ),
      )),
    );
  }

  Widget inputUserName() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Your username .. ",
        filled: true,
        prefixIcon: Icon(Icons.account_circle),
         border: InputBorder.none,
      ),
      controller: user,
    );
  }

  Widget submitBtn() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          "Continue".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainExpensesPage(user: user.text)),
          );
          print("button clicked");
        },
      ),
    );
  }
}
