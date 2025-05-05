import 'package:flutter/material.dart';
import 'package:flutter_application_24/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Add New",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            Text("User",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          ],
        ),
      ),

      body: Container(
        
        margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text("Name",style: TextStyle(color: Colors.black,fontSize: 20),),
            Container(
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(border: InputBorder.none,),
              ),
            ),
            SizedBox(height: 20.0,),

          Text("Email",style: TextStyle(color: Colors.black,fontSize: 20),),
            Container(
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(border: InputBorder.none,),
              ),
            ),
            SizedBox(height: 20.0,),

          Text("Location",style: TextStyle(color: Colors.black,fontSize: 20),),
            Container(
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(border: InputBorder.none,),
              ),
            ),
            SizedBox(height: 20.0,),

            ElevatedButton(onPressed: () async{
              String id = randomAlphaNumeric(10);
              Map<String,dynamic> userInofMap = {
                "username": usernameController.text,
                "email": emailController.text,
                "location": locationController.text,
                "id": id,
              }; 

              return await DatabaseMethods().addNewUser(userInofMap, id).then((value){
                  Fluttertoast.showToast(
                  msg: "New user Added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green.shade700,
                  textColor: Colors.white,
                  fontSize: 16.0,
                  webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
                  webPosition: "center"
                  );
              });
            }, child: Text("Add New User",style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20),),),
          ],
        ),
      ),
    );
  }
}