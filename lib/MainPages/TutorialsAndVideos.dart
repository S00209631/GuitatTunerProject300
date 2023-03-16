import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../NavigationBar/naviigation_drawer.dart';
import '../config.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key});
  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  //List to populate the carousel with articles
  List imageList = [
    {
      "id": 1,
      "image_url":
          'https://www.voicesinc.org/wp-content/uploads/2017/06/6-songwriting-tips.jpg',
      "link": 'https://www.voicesinc.org/songwriting-tips-for-guitar-players/'
    },
    {
      "id": 2,
      "image_url":
          'https://tomhess.net/files/images/Improve-Guitar-Technique-And-Play-Clean/How-To-Improve-Guitar-Technique-big.jpg',
      "link": 'https://tomhess.net/ImproveGuitarTechnique.aspx'
    },
    {
      "id": 3,
      "image_url":
          'https://yourguitarbrain.com/wp-content/uploads/2021/09/YGB-Header-Images_11-Playing-Guitar-Tips-Famous-Guitarists_Sept-5th-2021_PNG_14kb.png',
      "link":
          'https://yousician.com/lp/guitar?utm_source=google&utm_campaign=Yousician%20-%20Non%20Brand%20-%20Instrument%20-%20Guitar%20-%20Tier%202&utm_medium=cpc&utm_term=free%20online%20guitar%20lessons&gclid=Cj0KCQiAx6ugBhCcARIsAGNmMbjbV0N4kfbjc9zFtdcCaXQJ-P0CpzwTyMGoJC93TadQnVqQ5jsOxlYaAjWlEALw_wcB'
    }
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

//List to display Tutorial Videos
  List<String> videoUrls = [
    'https://www.youtube.com/watch?v=BBz-Jyr23M4',
    'https://www.youtube.com/watch?v=HNSaXAe8tyg',
    'https://www.youtube.com/watch?v=cUxRhesT8gY',
    'https://www.youtube.com/watch?v=RY3AvEGKfZ0',
  ];
  List<YoutubePlayerController> _controllers = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < videoUrls.length; i++) {
      _controllers.add(YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrls[i])!,
        flags: YoutubePlayerFlags(
          showLiveFullscreenButton: true,
          autoPlay: false,
          mute: false,
        ),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        drawer: const Drawer(
          child: NavigationDrawer(),
        ),
        appBar: AppBar(
          centerTitle: true,

          backgroundColor: Colors.transparent,
          title: Text('Tutorial And Tips'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Articles',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 250.0,
                child: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      carouselController: carouselController,
                      items: imageList.map((item) {
                        return GestureDetector(
                          onTap: () async {
                            print('Image tapped');
                            final url = item['link'];
                            if (await canLaunch(url)) {
                              await launch(Uri.parse(url).toString());
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.purpleAccent, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(
                                item['image_url'],
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.map((item) {
                          int index = imageList.indexOf(item);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == index
                                  ? Colors.purpleAccent
                                  : Colors.grey,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'YouTube Tutorials:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 16 / 9,
                children: videoUrls.map((url) {
                  return Container(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: Colors.purpleAccent,
                            width: 1,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            launch(url);
                          },
                          child: YoutubePlayer(
                            controller: _controllers[videoUrls.indexOf(url)],
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.purpleAccent,
                            bottomActions: [
                              CurrentPosition(),
                              SizedBox(width: 10),
                              ProgressBar(
                                isExpanded: true,
                                colors: ProgressBarColors(
                                  playedColor: Colors.purpleAccent,
                                  handleColor: Colors.purpleAccent,
                                ),
                              ),
                              SizedBox(width: 10),
                              RemainingDuration(),
                            ],
                            onEnded: (metadata) {
                              _controllers[videoUrls.indexOf(url)].pause();
                            },
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ],
          ),
        ));
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;

  const WebViewScreen({required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(title),
      ),
    );
  }
}
