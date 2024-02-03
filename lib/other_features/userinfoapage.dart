import 'package:flutter/material.dart';
import '../Unused/start_ameeting_page.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 11, 86),
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal:
                  30.0), // Add padding to ensure equal distance from left and right margin
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 100.0,
                color: Colors.white,
              ),
              SizedBox(height: 30.0),
              Text(
                'Username',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Email',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Phone Number',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              SizedBox(height: 100.0),
              ElevatedButton(
                onPressed: () {
                  _navigateToNextScreen(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Back Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4973C5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MeetingPage()));
  }
}



//void main() => runApp(MaterialApp(home: UserPage()));
