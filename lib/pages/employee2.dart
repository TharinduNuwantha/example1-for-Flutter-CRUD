import 'package:flutter/material.dart' ;
import 'package:flutter_application_24/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee2 extends StatefulWidget {
  const Employee2({super.key});

  @override
  State<Employee2> createState() => _Employee2State();
}

class _Employee2State extends State<Employee2> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Employee2",style: TextStyle(color: Colors.blue,fontSize: 24.0,fontWeight: FontWeight.bold),),
            Text("Fourm",style: TextStyle(color: Colors.orange,fontSize: 24.0,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0,top: 30.0,right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name",style: TextStyle(color: Colors.black, fontSize: 24.0,fontWeight: FontWeight.bold),),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(border: InputBorder.none,),
              ),
            ),
            SizedBox(height: 20.0,),

            Text("Age",style: TextStyle(color: Colors.black, fontSize: 24.0,fontWeight: FontWeight.bold),),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(border: InputBorder.none,),
              ),
            ),

            SizedBox(height: 20.0,),
            Text("Location",style: TextStyle(color: Colors.black, fontSize: 24.0,fontWeight: FontWeight.bold),),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(border: InputBorder.none,),
              ),
            ),
            SizedBox(height: 20.0,),
            Center(
            child:ElevatedButton(
              onPressed: () async{
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> employeeInfoMap = {
                  "Name": nameController.text,
                  "Age": ageController.text,
                  "id" : id,
                  "Location": locationController.text,
                };
                // Add your logic here to handle the employeeInfoMap
                
                return await DatabaseMethods().addEmployeeDetails2(employeeInfoMap, id)
                .then((value) {
                  Fluttertoast.showToast(
                  msg: "Employee Added",
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
              }, 
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.only(left: 100.0, right: 100.0, top: 20.0, bottom: 20.0),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}