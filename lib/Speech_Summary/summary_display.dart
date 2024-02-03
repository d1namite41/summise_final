/*import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'summary_display.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'dart:io';

String textpr = '';



class SummaryDisplay extends StatefulWidget {
  final String summary;
  const SummaryDisplay({Key? key, required this.summary}) : super(key: key);

  @override
  _SummaryDisplayState createState() => _SummaryDisplayState();
}

class _SummaryDisplayState extends State<SummaryDisplay> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.summary,
      style: TextStyle(color: Colors.blue),
    );
  }
}

class LongTextPage extends StatefulWidget {
  final String longText;
  const LongTextPage({Key? key, required this.longText}) : super(key: key);

  @override
  _LongTextPageState createState() => _LongTextPageState();
}

class _LongTextPageState extends State<LongTextPage> {
  String _summary = '';
  
  Future<void> _saveSummaryAsPdf(String summaryText) async {
  final pdf = pdfWidgets.Document();

  pdf.addPage(
    pdfWidgets.Page(
      build: (context) {
        return pdfWidgets.Center(
          child: pdfWidgets.Text(summaryText),
        );
      },
    ),
  );

  final appDocDir = await getApplicationDocumentsDirectory();
  final pdfPath = appDocDir.path + '/summary.pdf';
  final pdfFile = File(pdfPath);
  await pdfFile.writeAsBytes(await pdf.save());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('PDF Saved'),
        content: Text('Summary has been saved as PDF.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  Future<void> _getSummary() async {
    //print('test' + widget.longText);
    final apiKey = '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';
    final endpoint = 'https://api.openai.com/v1/completions';

    // Set the request headers and body
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = json.encode({
      'prompt':
          'Summarize and fact check the following text in a concise and formal matter in order to prestent the main ideas, while corecting potential errors and mistakes in it, using atmost 300 words: ' +
              widget.longText,
      'temperature': 0.1,
      'max_tokens': 1000,
      'model': 'text-davinci-003',
    });

    // Send the HTTP POST request to the API endpoint
    final response =
        await http.post(Uri.parse(endpoint), headers: headers, body: body);

    // Parse the response JSON and update the summary state
    final data = json.decode(response.body);
    final text = data['choices'][0]['text'];
    print(text);
    setState(() {
      _summary = 'this is the summary:' + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Long Text Page'),
        ),
        body: Column(children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _getSummary,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Get summary',
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
            ),
          ),
          SummaryDisplay(summary: _summary),
          ElevatedButton(
            onPressed: () {
              _saveSummaryAsPdf(_summary);
            },
            child: Text('Save as PDF'),
          ),
        ]));
  }
}
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

String textpr = '';

List<String> prompts = [
  "Summarize and fact check the following text, delimited by triple backticks, in a concise and formal matter in order to present the main ideas, while correcting potential errors and mistakes in it, using at most 100 words:",
  "Summarize and fact check the following text, delimited by triple backticks, in a fun and informal way in order to present the most interesting ideas, while correcting potential errors and mistakes in it and also making it simple and to read and learn from, using at most 100 words:",
  "Summarize and fact check the following text, delimited by triple backticks, correcting potential errors and mistakes in it, in a concise and technical matter in order to present the main ideas, while providing extra technical analisys and examples with the purpose of highlighting specialised content and notions of the prezented domanin, using at most 100 words:"
      "Summarize and fact check the following text, delimited by triple backticks, in a creative and formal matter that emphasies all interesting ideas, while correcting potential errors and mistakes in it, using around 100 words, you can use more to add factual and usedul information:",
  "Summarize and fact check the following text, delimited by triple backticks, in a concise and simple way in order for a kid smaller than 10 years old to understand the main ideas, while correcting potential errors and mistakes in it, using at most 100 words:"
];

List<String> filter_prompt = [
  "Pretend your a teacher asisstant, your job is to follow the subject presented in class and to proivde students with high quality summaries suited to their request.",
  "In addition to this filter the text excluding all content that is not related to the main topic (such as background noise or random interventions):"
];

class SummaryDisplay extends StatefulWidget {

  final String summary;
  final int val;
  const SummaryDisplay({Key? key, required this.summary, required this.val})
      : super(key: key);

  @override
  _SummaryDisplayState createState() => _SummaryDisplayState();
}

class _SummaryDisplayState extends State<SummaryDisplay> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.summary,
      style: TextStyle(color: Colors.blue),
    );
  }
}

class LongTextPage extends StatefulWidget {
  final String longText;
  final int val;
  const LongTextPage({Key? key, required this.longText, required this.val})
      : super(key: key);

  @override
  _LongTextPageState createState() => _LongTextPageState();
}

class _LongTextPageState extends State<LongTextPage> {
  String _summary = '';

  Future<void> _saveSummaryAsPdf(String summaryText) async {
    final pdf = pdfWidgets.Document();

    pdf.addPage(
      pdfWidgets.Page(
        build: (context) {
          return pdfWidgets.Center(
            child: pdfWidgets.Text(summaryText),
          );
        },
      ),
    );

    final appDocDir = await getApplicationDocumentsDirectory();
    final pdfPath = appDocDir.path + '/summary.pdf';
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('PDF Saved'),
          content: Text('Summary has been saved as PDF.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getSummary() async {
    //print('test' + widget.longText);
    final apiKey = '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';
    final endpoint = 'https://api.openai.com/v1/completions';

    // Set the request headers and body
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = json.encode({
      'prompt': prompts[widget.val] + "```" + widget.longText + "```",
      'temperature': 0.2,
      'max_tokens': 1000,
      'model': 'text-davinci-003',
    });

    // Send the HTTP POST request to the API endpoint
    final response =
        await http.post(Uri.parse(endpoint), headers: headers, body: body);

    // Parse the response JSON and update the summary state
    final data = json.decode(response.body);
    final text = data['choices'][0]['text'];
    print(text);
    setState(() {
      _summary = 'this is the summary:' + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Long Text Page'),
        ),
        body: Column(children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _getSummary,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Get summary',
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
            ),
          ),
          SummaryDisplay(summary: _summary, val: 0),
          ElevatedButton(
            onPressed: () {
              _saveSummaryAsPdf(_summary);
            },
            child: Text('Save as PDF'),
          ),
        ]));
  }
}
*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'dart:io';

String textpr = '';

List<String> prompts = [
  "Summarize and fact check the following text, delimited by triple backticks, in a concise and formal matter in order to present the main ideas, while correcting potential errors and mistakes in it, using at most 100 words:",
  "Summarize and fact check the following text, delimited by triple backticks, in a fun and informal way in order to present the most interesting ideas, while correcting potential errors and mistakes in it and also making it simple and to read and learn from, using at most 100 words:",
  "Summarize and fact check the following text, delimited by triple backticks, correcting potential errors and mistakes in it, in a concise and technical matter in order to present the main ideas, while providing extra technical analysis and examples with the purpose of highlighting specialized content and notions of the presented domain, using at most 100 words:",
  "Summarize and fact check the following text, delimited by triple backticks, in a creative and formal matter that emphasizes all interesting ideas, while correcting potential errors and mistakes in it, using around 100 words, you can use more to add factual and useful information:",
  "Summarize and fact check the following text, delimited by triple backticks, in a concise and simple way in order for a kid smaller than 10 years old to understand the main ideas, while correcting potential errors and mistakes in it, using at most 100 words:"
];

class SummaryDisplay extends StatefulWidget {
  final String summary;
  final int val;

  const SummaryDisplay({Key? key, required this.summary, required this.val})
      : super(key: key);

  @override
  _SummaryDisplayState createState() => _SummaryDisplayState();
}

class _SummaryDisplayState extends State<SummaryDisplay> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.summary,
      style: TextStyle(color: Colors.blue),
    );
  }
}

class LongTextPage extends StatefulWidget {
  final String longText;
  final int val;

  const LongTextPage({Key? key, required this.longText, required this.val})
      : super(key: key);

  @override
  _LongTextPageState createState() => _LongTextPageState();
}

class _LongTextPageState extends State<LongTextPage> {
  String _summary = '';

  Future<void> _saveSummaryAsPdf(String summaryText) async {
    final pdf = pdfWidgets.Document();

    pdf.addPage(
      pdfWidgets.Page(
        build: (context) {
          return pdfWidgets.Center(
            child: pdfWidgets.Text(summaryText),
          );
        },
      ),
    );

    final appDocDir = await getApplicationDocumentsDirectory();
    final pdfPath = appDocDir.path + '/summary.pdf';
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('PDF Saved'),
          content: Text('Summary has been saved as PDF.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getSummary() async {
    //print('test' + widget.longText);
    final apiKey = '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';
    final endpoint = 'https://api.openai.com/v1/completions';

    // Set the request headers and body
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = json.encode({
      'prompt': prompts[widget.val] + "```" + widget.longText + "```",
      'temperature': 0.2,
      'max_tokens': 1000,
      'model': 'text-davinci-003',
    });

    // Send the HTTP POST request to the API endpoint
    final response =
        await http.post(Uri.parse(endpoint), headers: headers, body: body);

    // Parse the response JSON and update the summary state
    final data = json.decode(response.body);
    final text = data['choices'][0]['text'];
    print(text);
    setState(() {
      _summary = 'this is the summary:' + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Long Text Page'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _getSummary,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Get summary',
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
            ),
          ),
          SummaryDisplay(summary: _summary, val: 0),
          ElevatedButton(
            onPressed: () {
              _saveSummaryAsPdf(_summary);
            },
            child: Text('Save as PDF'),
          ),
        ],
      ),
    );
  }
}

class Okkk extends StatefulWidget {
  @override
  _OkkkState createState() => _OkkkState();
}

class _OkkkState extends State<Okkk> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Flutter Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Name',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'The summary:',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String summaryText = _textController.text;
                await users
                    .add({'name': 'Alex', 'summary text': summaryText}).then(
                        (value) => print('Summary added for input comparison'));
              },
              child: const Text('Submit Data'),
            ),
          ],
        ),
      ),
    );
  }
}
