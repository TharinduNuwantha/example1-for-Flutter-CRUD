import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_24/pages/edit_employee.dart';
import 'package:flutter_application_24/pages/employee.dart';
import 'package:flutter_application_24/pages/employee2.dart';
import 'package:flutter_application_24/services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  Stream? EmployeeSream;

  getontheload()async{
    EmployeeSream = await DatabaseMethods().getEmployeeDetails();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allEmployeeDetails(){
    return (StreamBuilder(
      stream: EmployeeSream,
      builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name: "+ds["Name"],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  nameController.text = ds["Name"];
                                  ageController.text = ds["Age"].toString();
                                  locationController.text = ds["Location"];
                                  editEmployeeDetails(context, ds["id"]);
                                },
                                child: Icon(Icons.edit, color: Colors.orange),
                              ),
                              GestureDetector(
                                onTap: () async{
                                  await DatabaseMethods().deleteEmployee(ds['id']).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Employee Deleted"),));
                                  });
                                },
                                child: Icon(Icons.delete,color: Colors.red,),
                              )
                            ],
                          ),
                          Text(
                            "Age: " + ds["Age"].toString(),
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Location: " + ds["Location"],
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: Text("No data available"));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Employee2()),
    );

      },child: Icon(Icons.add),),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter",style: TextStyle(color: Colors.blue,fontSize: 24.0,fontWeight: FontWeight.bold),),
            Text("Firebase",style: TextStyle(color: Colors.orange,fontSize: 24.0,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails(),)
          ],
        ),
      ),
    );
  }

    Future editEmployeeDetails(BuildContext context, String id) => showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      child: Column(
        children: [
          Row(children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              }, 
              child: Icon(Icons.cancel,color: Colors.red,),
            ),
            Text("Edit",style: TextStyle(color: Colors.blue,fontSize: 24.0,fontWeight: FontWeight.bold),),
            Text("Detils",style: TextStyle(color: Colors.orange,fontSize: 24.0,fontWeight: FontWeight.bold),),
          ]),
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
              ),),
            SizedBox(height: 20.0,),
            ElevatedButton(onPressed: () async{
              Map<String,dynamic>updateInfo={
                "Name":nameController.text,
                "Age":ageController.text,
                "id":id,
                "Location":locationController.text,
              };

              await DatabaseMethods().UpdateEmployeeDetails(id, updateInfo).then((value) {
                Navigator.pop(context);
                nameController.clear();
                ageController.clear();
                locationController.clear();
              });

            }, child: Text("Update",style: TextStyle(color: const Color.fromARGB(255, 54, 22, 180),fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ],)
      ),
    ),
  );
}