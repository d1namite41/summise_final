import 'package:flutter/material.dart';
import '../Unused/start_ameeting_page.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 3, 11, 86), // Set background color to dark blue
      appBar: AppBar(
        title: const Text('Notifications'), // Set title text to "Notifications"
      ),
      body: Center(
        // Center the column vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MeetingPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {}, // No functionality assigned
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Notification 1 ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0, // No shadow
              ),
            ),
            ElevatedButton(
              onPressed: () {}, // No functionality assigned
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Notification 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0, // No shadow
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: NotificationsPage()));
