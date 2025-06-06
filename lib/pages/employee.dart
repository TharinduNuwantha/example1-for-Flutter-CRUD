import 'package:flutter/material.dart';
import 'package:flutter_application_24/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Employee",style: TextStyle(color: Colors.blue,fontSize: 24.0,fontWeight: FontWeight.bold),),
            Text("Firebase",style: TextStyle(color: Colors.orange,fontSize: 24.0,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0,top: 30.0,right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name",style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border.all( ),borderRadius: BorderRadius.circular(10 )),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
                controller: nameController,
              ),
            ),

            SizedBox(height: 20,),


            Text("Age",style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border.all( ),borderRadius: BorderRadius.circular(10 )),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
                controller: ageController,
              ),
            ),


            SizedBox(height: 20,),


            Text("Locatoion",style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border.all( ),borderRadius: BorderRadius.circular(10 )),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),

            SizedBox(height: 20,),

            Center(
              child: ElevatedButton(onPressed: () async {
                String Id = randomAlphaNumeric(10);
                Map<String, dynamic> employeeInofMap = {
                  "Name": nameController.text,
                  "Age": ageController.text,
                  "Id": Id,
                  "Location": locationController.text,
                };

                await DatabaseMethods().addEmployeeDetails(employeeInofMap, Id).then((value){
                  Fluttertoast.showToast(msg: "Employee Added Successfully",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 1,backgroundColor: Colors.green,textColor: Colors.white,fontSize: 16.0);
                });
              }, 
              child: Text("Add",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600),)
              ),
            ),
          ],
        ),
      ),
    );
}
}