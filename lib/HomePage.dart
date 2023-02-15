import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'naviigation_drawer.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47)),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    home: const MyHomePage(title: 'Chord Analyze')
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>with TickerProviderStateMixin {
  late AnimationController _controller;

  bool _isPlay = false;
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  final pitchupDart = PitchHandler(InstrumentType.guitar);
  var note = "";
  var status = "Click on start";
  void initState(){
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  Future<void> _startCapture() async {
    await _audioRecorder.start(listener, onError,
        sampleRate: 44100, bufferSize: 3000);
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const HomePage());
    setState(() {
      note = "";
    });
  }

  Future<void> _stopCapture() async {
    await _audioRecorder.stop();
    setState(() {
      note = "";
    });
  }

  void listener(dynamic obj) {
    //Gets the audio sample
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> audioSample = buffer.toList();
    //Uses pitch_detector_dart library to detect a pitch from the audio sample
    final result = pitchDetectorDart.getPitch(audioSample);
    //If there is a pitch - evaluate it
    if (result.pitched) {
      //Uses the pitchupDart library to check a given pitch for a Guitar
      final handledPitchResult = pitchupDart.handlePitch(result.pitch);
      //Updates the state with the result
      setState(() {
        note = handledPitchResult.note;
      });
    }
  }

  void onError(Object e) {
    print(e);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const Drawer(
        child: NavigationDrawer(),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [

          CachedNetworkImage(
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageUrl: 'https://i.ibb.co/hFTFj3w/ef4cc64952df617208dd1c9801ddee99-1-1-50-removebg-preview.png',
          ),
          const Spacer(),
          Center(
            child : GestureDetector(
              onTap : (){
                if (_isPlay == false){
                  _controller.forward();
                  _startCapture();
                  _isPlay = true;
                } else{
                  _controller.reverse();
                  _stopCapture();
                  _isPlay = false;
                }
              },
              child: AnimatedIcon(
                color: Colors.green,
                icon:AnimatedIcons.play_pause,
                progress: _controller,
                size: 100,
              ),
            ),
          ),
          Center(
              child: Text(
                "Note Played ",
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              )
          ),
          Center(
              child: Text(
                note,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              )
          ),
          Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                      )),
                  Expanded(
                      child: Center(
                          child: Container(
                          ))),
                ],
              ))
        ]),
      ),
    );
  }
}