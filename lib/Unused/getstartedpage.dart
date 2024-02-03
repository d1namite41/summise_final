import 'package:flutter/material.dart';
import 'start_ameeting_page.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: GettingStartedPage(),
//   ));
// }

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({Key? key}) : super(key: key);

  @override
  _GettingStartedPageState createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  bool _isNextButtonHovered = false;

  void _onNextButtonHover(bool isHovered) {
    setState(() {
      _isNextButtonHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09178E),
      appBar: AppBar(
        title: const Text(
          "Getting started?",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 100,
        ),
        child: Column(
          children: [
            const Text(
              "Look like you are new to us!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Create an account for a complete experience.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildInputField("Username"), // Input field for username
                  _buildInputField(
                      "Phone Number"), // Input field for phone number
                  _buildInputField("Password"), // Input field for password
                ],
              ),
            ),
            const SizedBox(height: 30),
            MouseRegion(
              onEnter: (_) => _onNextButtonHover(true),
              onExit: (_) => _onNextButtonHover(false),
              child: InkWell(
                onTap: () {
                  _navigateToNextScreen(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 50,
                  ),
                  decoration: BoxDecoration(
                    color:
                        _isNextButtonHovered ? Colors.blueAccent : Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2.0,
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: _isNextButtonHovered
                          ? Colors.white
                          : Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MeetingPage()));
  }
}
