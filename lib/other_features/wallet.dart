import 'package:flutter/material.dart';
import '../Unused/start_ameeting_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 11, 86),
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundPage(price: 8, points: const [
                '10 sumarises',
                '5 customizable',
                'affiliate program',
                'Point 4',
                'Point 5',
              ]),
              RoundPage(price: 10, points: const [
                'Point A',
                'Point B',
                'Point C',
                'Point D',
                'Point E',
              ]),
              RoundPage(price: 15, points: const [
                'Point X',
                'Point Y',
                'Point Z',
                'Point W',
                'Point V',
              ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyApp_st()));
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

class RoundPage extends StatelessWidget {
  final double price;
  final List<String> points;

  RoundPage({required this.price, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$$price',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: points.map((point) => Text(point)).toList(),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Pay'),
          ),
        ],
      ),
    );
  }
}
