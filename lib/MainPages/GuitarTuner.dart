import 'package:audioplayers/audio_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../config.dart';
import '../NavigationBar/naviigation_drawer.dart';

class GuitarTuner extends StatefulWidget {
  GuitarTuner({Key? key}) : super(key: key);

  @override
  _GuitarTuner createState() => _GuitarTuner();
}

class _GuitarTuner extends State<GuitarTuner> {
  double? frequency;
  String? note;
  int? octave;
  bool? isRecording;
  late final AudioCache _audioCache;
  double gaugeValue = 0;

  int string6 = 5;
  int string5 = 4;
  int string4 = 3;
  int string3 = 2;
  int string2 = 1;
  int string1 = 0;
  int selectedPosition = 5;
  bool isSuccess = false;

  bool isString6Success = false;
  bool isString5Success = false;
  bool isString4Success = false;
  bool isString3Success = false;
  bool isString2Success = false;
  bool isString1Success = false;
  List<double> gaugeRange6 = [0, 82, 164];
  List<double> gaugeRange5 = [0, 110, 220];
  List<double> gaugeRange4 = [0, 147, 294];
  List<double> gaugeRange3 = [0, 206, 412];
  List<double> gaugeRange2 = [0, 247, 494];
  List<double> gaugeRange1 = [0, 330, 660];
  List<double> gaugeRange = [];
  FlutterFft flutterFft = FlutterFft();
  int countClick = 0;
  int countShowAds = 6;
  _initialize() async {
    print("Starting recorder...");
    // print("Before");
    // bool hasPermission = await flutterFft.checkPermission();
    // print("After: " + hasPermission.toString());

    // Keep asking for mic permission until accepted
    while (!(await flutterFft.checkPermission())) {
      flutterFft.requestPermission();
      // IF DENY QUIT PROGRAM
    }

    // await flutterFft.checkPermissions();
    await flutterFft.startRecorder();
    print("Recorder started...");
    setState(() {
      isRecording = flutterFft.getIsRecording;
      //flutterFft.setTuning = ["E", "A", "D", "G", "B", "E"];
    });

    print(flutterFft.getTuning);
    flutterFft.onRecorderStateChanged.listen(
        (data) => {
              print("Changed state, received: $data"),
              setState(
                () => {
                  frequency = data[1] as double,
                  note = data[2] as String,
                  octave = data[5] as int,
                  isSuccess = data[10] as bool
                },
              ),
              flutterFft.setNote = note!,
              flutterFft.setFrequency = frequency!,
              gaugeValue = frequency!,
              flutterFft.setOctave = octave!,
              print('isSuccess : ${isSuccess.toString()}'),
              print("Octave: ${octave!.toString()}"),
              // if (flutterFft.getTuning[selectedPosition] ==
              //     note.toString() + octave.toString())
              //   {_audioCache.play('audio/success.wav')},
              if (selectedPosition == string6)
                {
                  if (flutterFft.getTuning[string6] ==
                      note.toString() + octave.toString())
                    {isString6Success = true}
                  else
                    {isString6Success = false}
                },
              if (selectedPosition == string5)
                {
                  if (flutterFft.getTuning[string5] ==
                      note.toString() + octave.toString())
                    {isString5Success = true}
                  else
                    {isString5Success = false}
                },
              if (selectedPosition == string4)
                {
                  if (flutterFft.getTuning[string4] ==
                      note.toString() + octave.toString())
                    {isString4Success = true}
                  else
                    {isString4Success = false}
                },
              if (selectedPosition == string3)
                {
                  if (flutterFft.getTuning[string3] ==
                      note.toString() + octave.toString())
                    {isString3Success = true}
                  else
                    {isString3Success = false}
                },
              if (selectedPosition == string2)
                {
                  if (flutterFft.getTuning[string2] ==
                      note.toString() + octave.toString())
                    {isString2Success = true}
                  else
                    {isString2Success = false}
                },
              if (selectedPosition == string1)
                {
                  if (flutterFft.getTuning[string1] ==
                      note.toString() + octave.toString())
                    {isString1Success = true}
                  else
                    {isString1Success = false}
                },
            },
        onError: (err) {
          print("Error: $err");
        },
        onDone: () => {print("Isdone")});
  }

  @override
  void initState() {
    _audioCache = AudioCache();
    gaugeRange = gaugeRange6;
    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    octave = flutterFft.getOctave;
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        drawer: const Drawer(
          backgroundColor: backgroundColor,
          child: NavigationDrawer(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Guitar Tuner'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageUrl:
                                'https://i.ibb.co/hFTFj3w/ef4cc64952df617208dd1c9801ddee99-1-1-50-removebg-preview.png',
                          )),

                          const SizedBox(height: 10.0),

                          // isRecording!
                          //     ? Text("Current frequency: ${frequency!.toStringAsFixed(2)}",
                          //         style: const TextStyle(fontSize: 16, color: Colors.white))
                          //     : const Text("Not Recording",
                          //         style: TextStyle(fontSize: 16, color: Colors.white)),
                          Container(
                            child: _getRadialGauge(),
                          ),
                          Center(
                            child: const Text(
                              'Chord Played',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                              child: Text(
                            note!,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          )),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                  height:
                                      30.0), // add a 16 pixel margin at the top

                              Text(
                                'Expected Frequencys',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Card(
                                elevation: 4.0,
                                margin: const EdgeInsets.fromLTRB(
                                    32.0, 10.0, 32.0, 16.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.music_note_rounded,
                                          color: Colors.purple),
                                      title: Text(
                                        "S6:Note 'E' = Frequency 82",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onTap: () {
                                        // your onTap function here
                                      },
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                      height: 1,
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.music_note_rounded,
                                          color: Colors.purple),
                                      title: Text(
                                        "S5:Note 'A' = Frequency 110",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onTap: () {
                                        // your onTap function here
                                      },
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                      height: 1,
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.music_note_rounded,
                                          color: Colors.purple),
                                      title: Text(
                                        "S4:Note 'D' = Frequency 147",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onTap: () {
                                        // your onTap function here
                                      },
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                      height: 1,
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.music_note_rounded,
                                          color: Colors.purple),
                                      title: Text(
                                        "S3:Note 'G' = Frequency 196",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onTap: () {
                                        // your onTap function here
                                      },
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                      height: 1,
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.music_note_rounded,
                                          color: Colors.purple),
                                      title: Text(
                                        "S2:Note 'B' = Frequency 247",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onTap: () {
                                        // your onTap function here
                                      },
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                      height: 1,
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.music_note_rounded,
                                          color: Colors.purple),
                                      title: Text(
                                        "S1:Note 'E' = Frequency 330",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onTap: () {
                                        // your onTap function here
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]))
              ],
            ),
          ]),
        )));
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
        // title: const GaugeTitle(
        //     text: 'Speedometer',
        //     textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        enableLoadingAnimation: true,
        animationDuration: 1000,
        axes: <RadialAxis>[
          RadialAxis(
              minimum: gaugeRange[0],
              maximum: gaugeRange[2],
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: gaugeRange[0],
                    endValue: gaugeRange[1],
                    gradient: const SweepGradient(
                      colors: <Color>[
                        redColor,
                        yellowColor,
                        greenColor,
                      ],
                      stops: <double>[
                        0,
                        0.555555,
                        0.777777,
                      ],
                    ),
                    startWidth: 10,
                    endWidth: 10),
                GaugeRange(
                    startValue: gaugeRange[1],
                    endValue: gaugeRange[2],
                    gradient: const SweepGradient(
                      colors: <Color>[
                        greenColor,
                        yellowColor,
                        redColor,
                      ],
                      stops: <double>[
                        0,
                        0.555555,
                        0.777777,
                      ],
                    ),
                    startWidth: 10,
                    endWidth: 10),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: gaugeValue,
                  enableAnimation: true,
                  needleColor: Colors.white,
                  needleLength: 1,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'frequency',
                          style: TextStyle(color: Colors.white30, fontSize: 12),
                        ),
                        Text('${gaugeValue.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    angle: 90,
                    positionFactor: 0.5)
              ])
        ]);
  }
}
