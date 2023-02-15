import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Chart'),
        centerTitle: true,
        backgroundColor: Colors.black,

      ),
      body: Container(
        child: Center(
          child: TabWidget(
            name: 'Chords Played',
            tabs: ["x 0 0 2 3 1", "x 5 7 7 6 5", "10 12 12 10 10 10"],
          ),
        ),
      ),

    );
  }
}
