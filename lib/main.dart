import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //decode-data for json.decode()
import 'dart:async';

void main() => runApp(AppApi());

class AppApi extends StatelessWidget {
  // const AppApi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api_call',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ApiHomePage(title: 'Flutter Api Call'),
    );
    
  }
}

class ApiHomePage extends StatefulWidget {
  ApiHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ApiHomePageState createState() => _ApiHomePageState();
}

class _ApiHomePageState extends State<ApiHomePage> {
  List data;

  Future<String> getData() async{
  //make api call
  var response = await http.get(
    Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
    // Uri.encodeFull('https://www.wattpad.com/157228296-waffle-cones'),
    headers: {"Accept": "application/json"}
  );

  //set app state
  setState(() {
    data = json.decode(response.body);
  });

  return "Sucess";
}

@override
void initState(){
  super.initState();
  getData();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Api Fetch"),
      ),
      body: Center(
        child: getList(),
      ),
    );
  }
  //Adding ListView
Widget getList(){
  if(data == null || data.length < 1){
    return Container(
     // color: Colors.green,
      child: Center (
        child: Text("...Loading"),
        ),
    );
  }
  return ListView.separated(
    itemCount: data?.length,
    itemBuilder: (BuildContext context, int index){
      return getListItem(index);
    },
    separatorBuilder: (context, index){
      return Divider();
    },
  );
}

  //fetch list
  Widget getListItem(int i){
    if(data == null || data.length < 1)
    return null;
    if(1==0){
      return Container(
        margin: EdgeInsets.all(4),
        child: Center(
          child: Text(
            "Titles",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      );
    }

    return Container(
      child: Container(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            data[i]['title'].toString(),
            style: TextStyle(fontSize: 18),
          ),
        )
      )
    );
  }

}



  

