import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      title: "Flutter List View",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String?, String?> _countries = Map<String?, String?>();

  List<String> _pets = ["Dogs, Cats, Tigers, Lions"];

  void _getData() async {
    var url = "http://country.io/names.json";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _countries = json.decode(response.body);
      });
      print('Loaded ${_countries.length} countries');
    } else {
      print("Status code: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter List View"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _pets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        _pets.elementAt(index),
                      );
                    }),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder: (BuildContext context, int index) {
                      String? key = _countries.keys.elementAt(index);
                      return Row(
                        children: [
                          Text('$key : '),
                          Text("${_countries[key]}"),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
