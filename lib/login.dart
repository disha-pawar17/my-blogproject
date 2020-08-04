import 'package:flutter/material.dart';
import 'package:flutterapp/dashboard.dart';
import 'package:flutterapp/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => login();
}

class login extends State<loginpage>{

  String email;
  String password;

  final TextEditingController emailcon= TextEditingController();
  final TextEditingController passwordcon= TextEditingController();

  GlobalKey<FormState> formkey=GlobalKey<FormState>();

  //Validation and design of email

    Widget _buildemail(){
      return Container(
        padding: EdgeInsets.all(20.0),
        child: TextFormField(keyboardType:TextInputType.emailAddress,controller: emailcon,
                decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Email"),
                validator: (String value){
                  if(value.isEmpty){
                    return "Required!";
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

  //Validation and design for password

    Widget _buildpass(){
      return  Container(
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
                  child: Container(
                    margin: EdgeInsets.only(top: 100.0),
                    child: Form(
                      key: formkey,
                      child:ListView(
                        children: <Widget>[
                          _buildemail(),
                          _buildpass(),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () async{
//                                validate();
                                    if(!formkey.currentState.validate()){
                                      Fluttertoast.showToast(msg: "Some error occured!!", toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.transparent,
                                          textColor: Colors.white, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1,fontSize: 16.0
                                      );
                                    }else {
                                      formkey.currentState.save();
                                      Fluttertoast.showToast(msg: "Registered succesfully!!", toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.transparent,
                                          textColor: Colors.white, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, fontSize: 16.0
                                      );
                                      emailcon.text="";
                                      passwordcon.text="";
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboardpage()));
                                    }
                                  },
                                  color: Colors.black,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          InkWell(
                            onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>signuppage()));
                            },
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                    text: 'Don\'t have a account ?',style: TextStyle(color: Colors.black),
                                    children: [TextSpan(
                                        text: ' Sign Up',
                                        style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold))]
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ),
              ),
      );
  }
}