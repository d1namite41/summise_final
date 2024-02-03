import 'package:flutter/material.dart';
import 'suport.dart';
import '../Unused/start_ameeting_page.dart';

class ChatAndSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 11, 86),
      appBar: AppBar(
        title: Text('Chat and Support'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50.0), // Adjust spacing from top margin
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyInfoPage()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Chat and Support',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Expanded(
              child:
                  Container()), // Add flexible container to center button vertically
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MeetingPage()));
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          const SizedBox(height: 50.0), // Adjust spacing from bottom margin
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ChatAndSupportPage()));
