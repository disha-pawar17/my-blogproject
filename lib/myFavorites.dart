import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'favoritesModel.dart';

class favoritepage extends StatefulWidget{
  favoritepage({Key key}):super(key: key);
  @override
  myfavorite createState() => myfavorite();
}
//To fetch specific user favorite data

Future<List<FavoriteModel>> fetchmyFavorites() async{
  final response =await http.get('https://jsonplaceholder.typicode.com/posts/1/comments');
  var myfavs= List<FavoriteModel>();

  if(response.statusCode==200){
    var favJson=json.decode(response.body);
    for (var favlist in favJson){
      myfavs.add(FavoriteModel.fromJson(favlist));
    }
  }
  else{
    throw Exception('Failed to load the Posts');
  }
  return myfavs;
}

 class myfavorite extends State<favoritepage>{

   Future<FavoriteModel> futurefav;
   List<FavoriteModel> _fav= List<FavoriteModel>();

   void initState(){
     fetchmyFavorites().then((value) {
       setState(() {
         _fav.addAll(value);
       });
     });
     super.initState();
   }

   @override
  Widget build(BuildContext context) {
     return Scaffold(appBar: AppBar(
       title: Text("BlogApp"),
     ),
       body:Container(
         color: Colors.grey[400],
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
                       _fav[index].name,
                       style: TextStyle(
                           fontSize: 22,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                     Text(
                       _fav[index].body,
                       style: TextStyle(
                         color: Colors.grey[800],
                       ),
                     ),
                     Container(
                       alignment: Alignment.bottomRight,
                       child: IconButton(
                         splashColor: Colors.red,
                         color:Colors.black,icon: Icon(Icons.favorite),
                         onPressed: (){Fluttertoast.showToast(msg: "Added as favorite!!", toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.transparent, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, fontSize: 16.0
                         );
                         },
                       ),
                     ),
                   ],
                 ),
               ),
             );
           },
           itemCount: _fav.length,
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