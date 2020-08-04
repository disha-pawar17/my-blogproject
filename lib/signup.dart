import 'package:flutter/material.dart';
import 'package:flutterapp/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class signuppage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>signup();
}
//To post data on Internet
Future<UserModel> createUser(String username,String email,String password,String contact) async{
  final String apiUrl="https://reqres.in/api/users";

  final response=await http.post(apiUrl,body: {
    "username":username,
    "email":email,
    "password":password,
    "contact":contact
  });
//
  if(response.statusCode==201){
    final String responseString =response.body;
    return userModelFromJson(responseString);
  }
  else{
    return null;
  }
}

class signup extends State<signuppage>{

  UserModel user;  //object of class user_model

  final TextEditingController usernamecon= TextEditingController();
  final TextEditingController emailcon= TextEditingController();
  final TextEditingController passwordcon= TextEditingController();
  final TextEditingController contactcon=TextEditingController();

  GlobalKey<FormState> formkey=GlobalKey<FormState>(); //form key

  String username;
  String email;
  String password;

  //Validation and design for username

  Widget _builduser(){
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(controller: usernamecon,
          decoration: InputDecoration(border: OutlineInputBorder(),labelText: "username"),
          validator: (String value){
            if(value.length==0) {
              return "Required!";
            }else if(value.length<4){
              return "Your username is too short";
            }
            else if(value.length >30){
              return "Your username is too long";
            }
            return null;
          }, onSaved: (String value){
            username=value;
          },
        ),
    );
  }

// Validation and design for Email

  Widget _buildemail(){
    return Container(
      padding: EdgeInsets.only(top:5,right: 20,left: 20),
      child: TextFormField(keyboardType:TextInputType.emailAddress,controller: emailcon,
          decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Email"),
          validator: (String value){
            if(value.isEmpty){
              return "required";
            }else if(!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return 'Please enter a valid email Address';
            }
            return null;
          }, onSaved: (String value){
            email=value;
          },
        ),
    );
  }
// Validation and design for Password

  Widget _buildpass(){
    return Container(
      padding: EdgeInsets.only(top:5,right: 20,left: 20),
      child: TextFormField(controller: passwordcon,
          decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Password"),
          obscureText: true,
          validator: (String value){
            if(value.isEmpty){
              return "required";
            }else if(value.length<6){
              return "Password is weak";
            }else if(value.length >30){
              return "Should be less than 30 characters";
            }
            return null;
          },onSaved: (String value){
            password=value;
          },
        ),
    );
  }

  //Validation for Contact number

  String validateMobile(String value) {
    String pattern = r'(^[7-9][0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number is not valid";
    }
    return null;
  }

  // To check current state is validated or not and execute appropriate action

  void validate(){
    if(!formkey.currentState.validate()){
      Fluttertoast.showToast(msg: "Some error occured!!", toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.transparent,
          textColor: Colors.white, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1,fontSize: 16.0
      );
    }else {
      formkey.currentState.save();
      Fluttertoast.showToast(msg: "Registered succesfully!!", toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.transparent,
          textColor: Colors.white, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, fontSize: 16.0
      );
      usernamecon.text="";
      emailcon.text="";
      passwordcon.text="";
      contactcon.text="";
      Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpage()));
    }
  }

//Actual layout using form widget

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("BlogApp"),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('images/blog-bg.jpg'),
              fit: BoxFit.cover)
              ),
              child: Center(
                child: Form(
                  key: formkey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      _builduser(),
                      SizedBox(height: 20,),
                      _buildemail(),
                      SizedBox(height: 20,),
                      _buildpass(),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.only(top:5,right: 20,left: 20),
                        child: TextFormField(controller: contactcon,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Contact"),
                          validator: validateMobile,
                        ),
                      ),

                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 50,
                            child: RaisedButton(
                              onPressed: () async{
                                validate();

                                final String username= usernamecon.text;
                                final String email= emailcon.text;
                                final String password=passwordcon.text;
                                final String contact=contactcon.text;

                                final UserModel _user=await createUser(username, email, password,contact);

                                setState(() {
                                  user=_user;
                                });
                              },
                              color: Colors.black,
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }