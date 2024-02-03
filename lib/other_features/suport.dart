import 'package:flutter/material.dart';

class MyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email =
        'support@summise.com'; // Replace with your desired email address
    String phoneNumber = '0721670920'; // Replace with your desired phone number

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 11, 86),
      appBar: AppBar(
        title: Text('My Info'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Email: $email',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Phone Number: $phoneNumber',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
