import 'package:flutter_application_2/firebase/login_page.dart';
import 'package:flutter_application_2/other_features/settings.dart';
import 'pagina_email_weneedyourmail.dart';
import 'package:flutter/material.dart';
import '../other_features/userinfoapage.dart';
import 'summary_page.dart';
import '../other_features/notif_page.dart';
import '../other_features/chattsupport.dart';
import '../Speech_Summary/sum_now.dart';
import '../other_features/wallet.dart';
import 'multi_lang.dart';

class MyApp_st extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Start a Meeting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MeetingPage(),
    );
  }
}

class MeetingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 11, 86),
      appBar: AppBar(
        title: Text('Start a Meeting'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SpeechToTextApp()));
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Start an instant meeting',
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
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Summary_Page()));
              }
            },
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Schedule a meeting',
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
          const SizedBox(height: 20.0),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserPage()));
                },
                child: const Text(
                  'User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0), // Added SizedBox for spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0), // Added SizedBox for spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationsPage()));
                },
                child: const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0), // Added SizedBox for spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                child: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0), // Added SizedBox for spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatAndSupportPage()));
                },
                child: const Text(
                  'Support',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0), // Added SizedBox for spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => lang()));
                },
                child: const Text(
                  'Meetings ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0), // Added SizedBox for spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPage()),
                  );
                },
                child: const Text(
                  'Wallet',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserPage()));
  }
}
