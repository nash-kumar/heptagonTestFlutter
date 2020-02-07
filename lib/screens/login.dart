import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:test_app/screens/data_list.dart';
import 'package:test_app/utilities/shared_preference.dart';
import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: kTextFieldDecoration.copyWith(hintText: "Username"),
                onChanged: (value){
                  email = value;
                },
              ),
              SizedBox(height: 20,),
              TextField(
                obscureText: true,
                onChanged: (value){
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: "password"),
              ),
              SizedBox(height: 10,),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                child: Text("Log In", style: TextStyle(
                  fontSize: 20
                ),),
                  onPressed: (){
                  print(email);
                    if(email == "test@email.com" && password == "password"){
                      SharedPref().addBoolToSF("user", true);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DataList()));
                    }else SweetAlert.show(context, title: "Incorrect credentials!!!", style: SweetAlertStyle.error);
                  })
            ],
          ),
        ),
      ),
    );
  }


}


