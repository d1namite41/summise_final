/*import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'summary_display.dart';
import 'start_ameeting_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

String textpr = '';

Future<String> getFilePath() async {
  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory.path; // 2
  String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

  return filePath;
}

void get_summary() async {
  final apiKey = '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';
  final endpoint = 'https://api.openai.com/v1/completions';

  // Set the request headers and body
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  final body = json.encode({
    'prompt': 'Summerise this text:',
    'temperature': 0.2,
    'max_tokens': 500,
    'model': 'gpt-3.5-turbo',
  });

  // Send the HTTP POST request to the API endpoint
  final response =
      await http.post(Uri.parse(endpoint), headers: headers, body: body);

  // Parse the response JSON and print the generated text
  final data = json.decode(response.body);
  final text = data['choices'][0]['text'];
  //print(text);
  textpr = text;
}

void main() async {
  runApp(MyApp3());
  // Set your API key and endpoint URL
}

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  String previousText = '';
  String _lastWords = '';
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted)
      throw 'Microphone permission not granted';
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    if (_lastWords != '') previousText = _lastWords;
    await _speechToText.listen(onResult: _onSpeechResult);
    _resetTimer();
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    //saveFile(_lastWords);
    // print(_lastWords);
    //get_summary();
    //print('this is the summary: ' + textpr);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LongTextPage(longText: _lastWords),
      ),
    );

    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      if (_speechToText.isNotListening && _lastWords != '')
        _startListening();
      else {
        _lastWords = previousText + result.recognizedWords;
        _resetTimer();
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 2), _startListening);
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MeetingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
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
                  primary: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
              ),
            ]),
            Container(
              padding: EdgeInsets.all(16),
              child: const Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  // If listening is active show the recognized words
                  _speechToText.isListening
                      ? '$_lastWords'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'summary_display.dart';
import 'dart:async';

void main() {
  runApp(SpeechToTextApp());
}

class SpeechToTextApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpeechToTextPage(),
    );
  }
}

class SpeechToTextPage extends StatefulWidget {
  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _fulltranscript = '';
  bool _isListening = false;
  bool _manuallyStopped = false;
  bool ok = true;
  String _recognizedText = 'Press the button and start speaking';
  int _selectedOption = 0; // Default option is "Formal"
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize(
      onError: (val) => print('onError: $val'),
    );
    if (!available) {
      print("Speech recognition not available");
    }
  }

  void _toggleListening() async {
    bool available = await _speech.initialize(
      onError: (val) => print('onError: $val'),
    );

    if (!_manuallyStopped) {
      if (ok) {
        _resetTimer();
        ok = false;
      }
      if (available) {
        _manuallyStopped = true;
        _speech.listen(
          onResult: (val) {
            setState(() {
              _recognizedText = val.recognizedWords;
            });
            _resetTimer();
          },
        );
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false; // Set _isListening to false when manually stopped
        _manuallyStopped = false;
        ok = true;
        _fulltranscript += _recognizedText;
        _timer?.cancel();
      });
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        if (_manuallyStopped) {
          _fulltranscript += _recognizedText;
          ok = true;
          _manuallyStopped = false;
          _toggleListening();
        }
      });
    });
  }

  void _onDropdownChanged(int? value) {
    if (value != null) {
      setState(() {
        _selectedOption = value;
      });

      // Do something with the selected option (1, 2, 3, 4, or 5)
      print('Selected Option: $_selectedOption');
    }
  }

  void _generateSummary() {
    // Handle the summary button press here
    // You can add your logic to generate and display a summary
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LongTextPage(
        longText: _fulltranscript,
        val: _selectedOption,
      ),
    ));
  }

  @override
  void dispose() {
    _speech.stop();
    _resetTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text Demo'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _toggleListening,
            child: Icon(_manuallyStopped ? Icons.stop : Icons.mic),
          ),
          SizedBox(height: 16.0), // Add some spacing
          FloatingActionButton(
            onPressed: _generateSummary,
            child: Icon(Icons.article), // You can use any icon you like
          ),
          SizedBox(height: 16.0), // Add some spacing
          DropdownButton<int>(
            value: _selectedOption,
            items: [
              DropdownMenuItem<int>(
                value: 0,
                child: Text('Formal'),
              ),
              DropdownMenuItem<int>(
                value: 1,
                child: Text('Informal'),
              ),
              DropdownMenuItem<int>(
                value: 2,
                child: Text('Technical'),
              ),
              DropdownMenuItem<int>(
                value: 3,
                child: Text('Creative'),
              ),
              DropdownMenuItem<int>(
                value: 5,
                child: Text('Young'),
              ),
            ],
            onChanged: _onDropdownChanged,
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            _recognizedText,
            style: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
