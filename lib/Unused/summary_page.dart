import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../main.dart';

List<int> types = [0, 1, 2];

class Summary_Page extends StatelessWidget {
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2025, 12),
    );
    if (picked != null && picked != DateTime.now())
      controller.text = DateFormat('MM/dd/yy').format(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 11, 86),
      appBar: AppBar(title: const Text('Schedule a meeting')),
      body: Center(
        child: ListView.builder(
          itemExtent: 370.0,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.transparent,
                  width: 20.0,
                ),
              ),
              child:
                  _buildListItem(context, index), // add context argument here
            );
          },
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    String title = '';
    Color colort = Colors.black;
    switch (types[index]) {
      case 0:
        title = 'Flagged';
        colort = Color.fromARGB(255, 117, 142, 216);
        break;
      case 1:
        title = 'Upcoming';
        colort = Color(0xFF4973C5);
        break;
      case 2:
        title = 'Approved';
        colort = Color.fromARGB(255, 39, 73, 141);
        break;
      case 3:
        title = 'Open';
        colort = Color.fromARGB(255, 6, 21, 50);
        break;
      default:
        break;
    }

    TextEditingController dateController =
        TextEditingController(text: "04/14/23");

    Future<void> _selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2025, 12),
      );
      if (picked != null && picked != DateTime.now())
        dateController.text = DateFormat('MM/dd/yy').format(picked);
    }

    Widget Form_title = TextFormField(
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        labelText: 'Meeting Name',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: (value) {},
    );

    Widget titleWidget = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      },
      child: Center(
        child: Container(
          width: 370.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
      ),
    );

    Widget dateWidget = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(255, 44, 44, 44),
          border: Border.all(
            color: Colors.white,
            width: 7.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        width: 370.0,
        child: TextField(
          controller: dateController,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 24),
          onTap: () => _selectDate(),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );

    Widget entryWidget = Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Center(child: Text("Entry " + "$index")),
    );

    Widget backGround = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: colort,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 81, 202, 250).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form_title,
              SizedBox(height: 16.0),
              titleWidget,
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dateWidget,
                ],
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ));

    return backGround;
  }
}
