import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/MainPages/GuitarTuner.dart';
import 'package:project/MainPages/Recordings.dart';
import '../NavigationBar/naviigation_drawer.dart';
import '../config.dart';
import 'TutorialsAndVideos.dart';

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
  late bool _dark;
  get title => null;
  @override
  void initState() {
    super.initState();
    _dark = true;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        drawer: const Drawer(
          backgroundColor: backgroundColor,
          child: NavigationDrawer(),
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'HomePage',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.purple,
                    child: ListTile(
                      onTap: () {
                        //open edit profile
                      },
                      title: Text(
                        "Welcome Back  :    Daniel Stanislawski",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ),
                  ),

                  const SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16.0), // add a 16 pixel margin at the top
                  Text(
                    'Quick Access',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.guitar,
                            color: Colors.purple,
                          ),
                          title: Text("Guitar Tuner"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  GuitarTuner()));
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.fileAudio,
                            color: Colors.purple,
                          ),
                          title: Text("Saved Recordings"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecorderPage(title: 'Recorded Audios')));
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.video,
                            color: Colors.purple,
                          ),
                          title: Text("Tutorials"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  SliderScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                  child : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Column(

                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Our App',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                    Container(
                      width: 150.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Tune your guitar with ease using our app. Enjoy a user-friendly interface, real-time feedback, and a variety of tuning options. Perfect for all skill levels - beginner to pro',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                      SizedBox(width: 16.0),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ),
                    Container(
                      width: 150.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.video,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(height: 5.0),
                                    Text('Tutorials\n Articles', style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.guitar,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text('Guitar \nTuner ', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(height: 5.0),
                                    Text('   User\nFriendly', style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.fileAudio,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text('  Audio\nrecorder', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.moneyBill,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(height: 5.0),
                                    Text('   Free\nService', style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.music,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text('RealTime\n  Tuning',style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ],
                  )
                ]
                  )
                  )
                ],
              ),
              ]
            ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}