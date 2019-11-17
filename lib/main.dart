import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fetching Data from Api'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String url ="https://api.themoviedb.org/3/discover/movie?api_key=d9c5ecab3442edcfdb62d87dbcea8a0c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
    
  }
  Future<String> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {'Accept':'application/json'}
    );

    print(response.body);

  setState(() {
    var convertDataToJson = json.decode(response.body);
    data = convertDataToJson['results'];
  });

  return 'Success';
  }
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: ListView.builder(
            itemCount: data==null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                          child: Container(
                        child: Text(
                          data[index]['title'],
                          style: TextStyle(fontSize: 25),
                        ),
                        padding: EdgeInsets.all(20),
                      ))
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    

}
