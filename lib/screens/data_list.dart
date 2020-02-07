import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/screens/login.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';



import 'package:test_app/utilities/shared_preference.dart';

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List details = [];
  bool isWaiting = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: _image == null ? AssetImage("assets/download.png") : FileImage(_image)
            ),
            Spacer(flex: 2,),
            GestureDetector(
                child: Icon(Icons.file_upload),
            onTap: ()async{
              File file = await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: "pdf" );
              showDialog(context: context, child: AlertDialog(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("File Name : ${file.path.split('/').last}"),
                    Text("File Length : ${file.lengthSync()}Kb"),
                    Text("Path: ${file.path}")
                  ],
                ),
              ));
              print("${file.lengthSync()}");
            },),

            SizedBox(width: 30,),
            GestureDetector(
                child: Text("Logout"),
              onTap: (){
                  SharedPref().remove("user");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
              },
            ),
            SizedBox(width: 10,)
          ],
        ),
      ),
      body: Container(
        child: isWaiting ? Center(child: CircularProgressIndicator()) : ListView.builder(itemCount: details.length,itemBuilder: (BuildContext context, int index){
            return Card(
              elevation: 2.0,
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Text("${details[index]["userId"].toString()}  ${details[index]["title"]}"),
                subtitle: Text(details[index]["body"], textAlign: TextAlign.justify,),
                isThreeLine: true,
              ),
            );
        })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.camera_alt),
      ),
    );
  }


  Future<List> getData()async{
    try{
      const url = "https://jsonplaceholder.typicode.com/posts";
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        var decodeData = jsonDecode(response.body);
        setState(() {
          details = decodeData;
          isWaiting = false;
        });
      }

    } catch(err){
      return err;
    }
  }
  @override
  void initState() {
    getData();
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Log in succesfull",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            duration: Duration(milliseconds: 2000))));
    super.initState();
  }

}
