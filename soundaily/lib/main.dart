
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(SoundailyApp());
}

class SoundailyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundaily',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SoundailyHomePage(),
    );
  }
}

class SoundailyHomePage extends StatefulWidget {
  @override
  _SoundailyHomePageState createState() => _SoundailyHomePageState();
}

class _SoundailyHomePageState extends State<SoundailyHomePage> {
  Map<String, dynamic>? trackData;

  Future<void> getTrackData() async {
    final options = {
      'method': 'GET',
      'url': 'https://deezerdevs-deezer.p.rapidapi.com/track/%7Bid%7D',
      'headers': {
        'X-RapidAPI-Key': 'feaff4f1bfmsh8b6cd5e2c72d205p1987c8jsn827389d7e25d',
        'X-RapidAPI-Host': 'deezerdevs-deezer.p.rapidapi.com',
      },
    };

    final response = await http.get(Uri.parse(options['url']), headers: options['headers']);

    if (response.statusCode == 200) {
      setState(() {
        trackData = json.decode(response.body);
      });
    } else {
      // Gérer l'erreur de requête ici
    }
  }

  @override
  void initState() {
    super.initState();
    getTrackData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soundaily'),
      ),
      body: trackData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  trackData!['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(trackData!['artist']['name']),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: getTrackData,
                  child: Text('Get Track Data'),
                ),
              ],
            ),
    );
  }
}