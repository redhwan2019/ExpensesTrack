import 'package:excer/pages/expenses/create.dart';
import 'package:excer/pages/expenses/login.dart';
import 'package:excer/pages/expenses/update.dart';
import 'package:excer/services/helper-service.dart';
import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';

class MainExpensesPage extends StatefulWidget {
  final String user;

  MainExpensesPage({this.user});
  @override
  _MainExpensesPageState createState() => _MainExpensesPageState();
}

class _MainExpensesPageState extends State<MainExpensesPage> {
  List listExpenses = [];
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Tracker"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          headerSection(),
          bodySection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          goToCreatePage();
        },
      ),
    );
  }

  Widget headerSection() {
    return Expanded(
      flex: 1,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          color: Colors.green,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Hi " + widget.user,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                "Total spending is RM $total",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodySection() {
    return Expanded(
      flex: 3,
      child: ListView.builder(
        itemCount: listExpenses.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(listExpenses[i]['amount']),
            subtitle: Text(listExpenses[i]['date']),
            trailing: Text(
              listExpenses[i]['category']['name'],
              style: TextStyle(
                backgroundColor: HexColor(listExpenses[i]['category']['hex']),
              ),
            ),
            leading: CircleAvatar(
              child: Image.asset(
                listExpenses[i]['photo'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              goToUpdatePage(listExpenses[i], i);
            },
          );
        },
      ),
    );
  }

  void goToCreatePage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateExpensesPage(),
      ),
    );
    if (result != null) {
      setState(() {
        listExpenses.insert(0, result);
        total = HelperService().countTotal(listExpenses);
      });
    }
  }

  void goToUpdatePage(Map objj, int i) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateExpense(current: objj),
      ),
    );
    if (result != null) {
      listExpenses.removeAt(i);
      if (result != "delete") {
        listExpenses.insert(i, result);
      }
    }
    total = HelperService().countTotal(listExpenses);
  }
} // end
