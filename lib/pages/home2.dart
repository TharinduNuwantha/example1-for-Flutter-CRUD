import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_24/pages/pake_profile.dart';
import 'package:flutter_application_24/services/database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  Stream? UserStrem;
  getOntheLoad()async{
    UserStrem = await DatabaseMethods().getUserDetails();
    setState(() {
      
    });
  } 
  @override 
  void initState() {
    super.initState();
    getOntheLoad();
  }
  Widget allUserList(){
    return (StreamBuilder(
      stream: UserStrem,
      builder: (context,AsyncSnapshot snapshot){

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }


        return snapshot.hasData
        ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot ds = snapshot.data.docs[index];
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ds['username'],style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
                              GestureDetector(
                                onTap: (){
                                  usernameController.text = ds['username'];
                                  emailController.text = ds['email'];
                                  locationController.text = ds['location'];
                                  editUserDetails(context,ds['id']);
                                },
                                child: Icon(Icons.edit,color: Colors.blue,),
                              ),
                              GestureDetector(
                                onTap: () async{
                                  await DatabaseMethods().deleteUser(ds['id']).then((value){
                                        Fluttertoast.showToast(
                                        msg: "User Deleted",
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
                                },child: Icon(Icons.delete,color: Colors.red,),
                              )
                            ],
                          ),
                          Text(ds['email'],style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
                          Text(ds['location'],style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            
          ) : Center(child: Text("No data available"),);
        
      } ,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewUser(),));
        
      }, child: Icon(Icons.add),),
      appBar: AppBar(
        title: Text("User Profile", style: TextStyle(color: const Color.fromARGB(255, 250, 21, 174), fontSize: 24.0, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        child: Column(
          children: [
              Expanded(child: allUserList()),
          ],
        ),
      ),
    );
  }

  Future editUserDetails(BuildContext context,String id) => showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Edit User",style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close,color: Colors.red,),
            ),
            
          ],),

          SizedBox(height: 20.0,),
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
            ElevatedButton(onPressed: ()async{
              Map<String,dynamic>updateInfo ={
                "username": usernameController.text,
                "email": emailController.text,
                "location":locationController.text,
                "id": id,
              };
              await DatabaseMethods().UpdateUserDetails(id, updateInfo).then((value){
                Navigator.pop(context);
                usernameController.clear();
                emailController.clear();
                locationController.clear();
              });
              
            },child: Text("Update"),),
        ],
      ),
    ),
  ));
}