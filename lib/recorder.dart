import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
void main() {
  runApp(const Recorder());
}
class Recorder extends StatelessWidget {
  const Recorder({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const RecorderPage(title: 'Chordanalyze'),
    );
  }
}
class RecorderPage extends StatefulWidget {
  const RecorderPage({super.key, required this.title});
  final String title;
  @override
  State<RecorderPage> createState() => _RecorderPageState();
}
class _RecorderPageState extends State<RecorderPage> {
  //variable
  //player
  final AudioPlayer _player = AudioPlayer();

  void deleteItem(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    setState(() {
      // Code to update the list goes here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
          builder: (context, item){
            if(item.hasData){
              Map? jsonMap = json.decode(item.data!);
              List? songs = jsonMap?.keys.toList();
              return ListView.builder(
                itemCount: songs?.length,
                itemBuilder: (context, index){
                  var path = songs![index].toString();
                  var title = path.split("/").last.toString();
                  title = title.replaceAll("%20", "");
                  title = title.split(".").first;
                  return Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text("path: $path"),
                      leading: const Icon(Icons.audiotrack, size: 20,),
                      onTap: () async{
                        await _player.setAsset(path);
                        await _player.play();
                      },

                    ),
                  );

                },
              );
            }else{
              return const Center(
                child: Text("No Audio Available"),
              );
            }
          }
      ),
    );
  }
}