import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/postModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'myFavorites.dart';

class dashboardpage extends StatefulWidget{
  dashboardpage({Key key}):super(key: key);
  @override
  dashboard createState() => dashboard();
}

// To get data from internet

Future<List<PostModel>> fetchpostModel() async{
  final response =await http.get('https://jsonplaceholder.typicode.com/posts');
  var posts= List<PostModel>();

  if(response.statusCode==200){
    var postJson=json.decode(response.body);
    for (var postlist in postJson){
      posts.add(PostModel.fromJson(postlist));
    }
  }
  else{
    throw Exception('Failed to load the Posts');
  }
  return posts;
}

class dashboard extends State<dashboardpage> {

  String finalDate='';
  Future<PostModel> futurepost;
  List<PostModel> _post= List<PostModel>();

  void initState(){
    fetchpostModel().then((value) {
      setState(() {
        _post.addAll(value);
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlogApp"),
      ),
      body: Container(
        color: Colors.grey[400],
        child: Column(
          children: <Widget>[
            Text("Recent posts",style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 30,letterSpacing: 1),
              ),
            Card(
              child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>favoritepage()));},
                child: Container(
                  width:500 ,
                  height: 50,
                  color: Colors.red[200],
                  child: Text("See my Favorites",style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),textAlign: TextAlign.center,),
                ),),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color:Colors.blueGrey[300],
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 32.0, left: 16.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topRight,
                            child: MydateWidget(),
                          ),
                          Text(
                            _post[index].title,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            _post[index].body,
                            style: TextStyle(
                                color: Colors.grey[800],
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              splashColor: Colors.red,
                              color:Colors.black,icon: Icon(Icons.favorite_border),
                              onPressed: (){Fluttertoast.showToast(msg: "Added as favorite!!", toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.transparent,
                                textColor: Colors.white, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, fontSize: 16.0
                            );
                            },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _post.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// for current time and date

class MydateWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return Text('date: ${now.day}/${now.month}/${now.year}');
  }
}