import 'package:flutter/material.dart';

void main() {
  runApp(SettingsPage());
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Create a curved animation
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 11, 86),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSettingButton('Notification Settings'),
              SizedBox(height: 20.0), // Increased spacing between buttons
              buildSettingButton('Account Settings'),
              SizedBox(height: 20.0), // Increased spacing between buttons
              buildSettingButton('Privacy Settings'),
              SizedBox(height: 20.0), // Increased spacing between buttons
              buildSettingButton('Appearance Settings'),
              SizedBox(height: 20.0), // Increased spacing between buttons
              buildSettingButton('About'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingButton(String title) {
    return ScaleTransition(
      scale: _animation,
      child: FadeTransition(
        opacity: _animation,
        child: ElevatedButton(
          onPressed: () {
            // Button onPressed logic
          },
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
