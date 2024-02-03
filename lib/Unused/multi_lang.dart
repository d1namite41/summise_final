import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_speech/google_speech.dart';
import 'package:google_speech/speech_client_authenticator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

String _lastWords = '';
String textpr = '';
String chatGptResponse = '';

void get_summary() async {
  print(_lastWords);
  final apiKey = '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 ';
  final endpoint = 'https://api.openai.com/v1/completions';

  // Set the request headers and body
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  final body = json.encode({
    'prompt':
        'System: Fara diacritice scoate 2 idei princiaple din urmatorul text in romana fara diacritice. Text: $_lastWords',
    'model': 'text-davinci-003',
    'temperature': 0.1,
  });

  // Send the HTTP POST request to the API endpoint
  final response =
      await http.post(Uri.parse(endpoint), headers: headers, body: body);

  // Parse the response JSON and retrieve the generated response
  final data = json.decode(response.body);

  chatGptResponse = data['choices'][0]['text'];

  print(chatGptResponse);
}

class lang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Recorder, Player, and Transcriber',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum PlayerState { stopped, playing }

class _MyHomePageState extends State<MyHomePage> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  PlayerState _playerState = PlayerState.stopped;
  bool _isTranscribing = false;
  String _content = '';
  late Directory _appDir;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _recorder!.openAudioSession().then((value) {
      _player!.openAudioSession().then((value) {
        setState(() {});
      });
    });
    setPermissions();
  }

  void setPermissions() async {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();
  }

  @override
  void dispose() {
    _recorder!.closeAudioSession();
    _player!.closeAudioSession();
    super.dispose();
  }

  void displayAudioSize(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      final sizeInBytes = file.lengthSync();
      final sizeInKB = (sizeInBytes / 1024).toStringAsFixed(2);
      final sizeInMB = (sizeInBytes / (1024 * 1024)).toStringAsFixed(2);

      print('Audio Size:');
      print('Bytes: $sizeInBytes');
      print('KB: $sizeInKB');
      print('MB: $sizeInMB');
    } else {
      print('File does not exist');
    }
  }

  Future<void> _startRecording() async {
    _appDir =
        await getApplicationDocumentsDirectory(); // Assign the app directory
    final filePath = '${_appDir.path}/test.wav';
    final chestiiDir = Directory('${_appDir.path}/chestii');
    if (!chestiiDir.existsSync()) {
      chestiiDir.createSync();
    }

    await _recorder!.startRecorder(toFile: filePath, codec: Codec.pcm16WAV);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();

    final filePath = '${_appDir.path}/test.wav';
    displayAudioSize(filePath);
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _startPlaying() async {
    final appDir = await getApplicationDocumentsDirectory();
    final filePath = '${_appDir.path}/test.wav';

    await _player!.startPlayer(
      fromURI: filePath,
      codec: Codec.pcm16WAV,
    );

    setState(() {
      _playerState = PlayerState.playing;
    });
  }

  Future<void> _stopPlaying() async {
    await _player!.stopPlayer();
    setState(() {
      _playerState = PlayerState.stopped;
    });
  }

  Future<void> _transcribe() async {
    setState(() {
      _isTranscribing = true;
    });

    final serviceAccount = ServiceAccount.fromString(await rootBundle
        .loadString('chestii/ferrous-wonder-391916-d719ad256eb2.json'));

    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);

    final config = RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      audioChannelCount: 1,
      languageCode: 'ro-RO',
    );

    final audio = await _getAudioContent('${_appDir.path}/test.wav');
    await speechToText.recognize(config, audio).then((value) {
      setState(() {
        _content = value.results
            .map((e) => e.alternatives.first.transcript)
            .join('\n');
      });
    }).whenComplete(() {
      _lastWords = _content;
      get_summary();
      setState(() {
        _isTranscribing = false;
      });
    });

    // Invoke GPT-3.5 Chat API with transcribed speech as input
  }

  Future<List<int>> _getAudioContent(String name) async {
    final file = File(name);
    if (file.existsSync()) {
      return await file.readAsBytes();
    } else {
      throw Exception('File not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder, Player, and Transcriber'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playerState == PlayerState.playing
                  ? _stopPlaying
                  : _startPlaying,
              child: Text(_playerState == PlayerState.playing
                  ? 'Stop Playing'
                  : 'Start Playing'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isTranscribing ? null : _transcribe,
              child: _isTranscribing
                  ? CircularProgressIndicator()
                  : Text('Transcribe'),
            ),
            SizedBox(height: 20),
            Container(
              height: 400,
              width: 600,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(5.0),
              child: _content == ''
                  ? Text(
                      'Your text will appear here',
                      style: TextStyle(color: Colors.grey),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            chatGptResponse,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed:
                                _content.isEmpty ? null : () => get_summary(),
                            child: Text('Get ChatGPT Response'),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "test" + chatGptResponse,
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
