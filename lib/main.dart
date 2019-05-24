import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_youtube_app/model/video.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(home: MyApp(),));

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  var youtube = new FlutterYoutube();

  Future<String> _loadVideoAsset() async {
    return await rootBundle.loadString('json/videos.json');
  }

  Future<VideoList> loadVideos() async {
    String jsonVideos = await _loadVideoAsset();

    final jsonResponse = json.decode(jsonVideos);

    return VideoList.fromJson(jsonResponse);
  }

  void playYoutubeVideo(String url) {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: 'AIzaSyDc5EEvzld0BGNH8pfec7O4EXl8TR_2zIA',
      videoUrl: url,
      autoPlay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Youtube videos'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder<VideoList>(
          future: loadVideos(),
          builder: (BuildContext context, AsyncSnapshot<VideoList> snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasError) {
                return ErrorWidget(snapshot.error);
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                          title: Text(snapshot.data.videos[index].nombre),
                          subtitle: Text('Flutter widget'),
                          leading: FlutterLogo(size: 30,),
                          trailing: IconButton(
                            icon: Icon(Icons.play_circle_outline,color: Colors.blue,),
                            onPressed: () {
                              playYoutubeVideo(snapshot.data.videos[index].url);
                            },
                          )),
                      Divider()
                    ],
                  );
                },
                itemCount: snapshot.data.videos.length,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
