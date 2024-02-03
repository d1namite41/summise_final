import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Page',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: BluePage(text: 'Welcome to the Blue Page'),
    );
  }
}

class BluePage extends StatefulWidget {
  final String text;

  BluePage({required this.text});

  @override
  _BluePageState createState() => _BluePageState();
}

class _BluePageState extends State<BluePage> {
  late TextEditingController _textEditingController;
  String _currentText = '';
  List<String> _textHistory = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.text);
    _currentText = widget.text;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateText(String newText) {
    setState(() {
      _currentText = newText;
    });
  }

  void _undoText() {
    setState(() {
      if (_textHistory.isNotEmpty) {
        _currentText = _textHistory.removeLast();
        _textEditingController.text = _currentText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                  ),
                  child: Center(
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: (newText) {
                        _updateText(newText);
                      },
                      onSubmitted: (text) {
                        _textHistory.add(_currentText);
                      },
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: null, // Allow unlimited lines
                      keyboardType:
                          TextInputType.multiline, // Enable multiline input
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedButton(
                    onPressed: () {
                      _undoText();
                    },
                    child: const Text('Undo'),
                  ),
                  AnimatedButton(
                    onPressed: () {
                      // Button 2 action
                    },
                    child: const Text('Button 2'),
                  ),
                  AnimatedButton(
                    onPressed: () {
                      // Button 3 action
                    },
                    child: const Text('Button 3'),
                  ),
                  AnimatedButton(
                    onPressed: () {
                      // Button 4 action
                    },
                    child: const Text('Button 4'),
                  ),
                  AnimatedButton(
                    onPressed: () {
                      // Button 5 action
                    },
                    child: const Text('Button 5'),
                  ),
                  AnimatedButton(
                    onPressed: () {
                      // Button 6 action
                    },
                    child: const Text('Button 6'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AnimatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (_isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: InkWell(
          onTap: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}
