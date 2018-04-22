import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://hotelieu.azurewebsites.net/api/duyuru"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = JSON.decode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Web Api to List View"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return
            new Card(
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        width: 60.0,
                        height: 60.0,
                        margin: const EdgeInsets.all(10.0),
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.black12),
                            shape: BoxShape.circle,
                            image: new DecorationImage(image: new AssetImage('assets/ege-senkul.jpg'))
                        ),
                      ),
                      new Text(data[index]["baslik"],style: new TextStyle(fontWeight: FontWeight.bold)),

                    ],
                  ),
                  new Image.asset(
                    'assets/ege-ibiza.jpg',
                    width: 400.0,
                    height: 300.0,
                    fit: BoxFit.fill,
                  ),
                  new ListTile(
                    title: new Text(data[index]["icerik"],
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: new Text(data[index]["duyuruTarihi"]),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                  ),
                ],
              ),
            );
        },
      ),
    );
  }
}