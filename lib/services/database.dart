import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods{
  Future addEmployeeDetails(Map<String, dynamic>employeeInofMap,String id) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).set(employeeInofMap);
  }

  Future addEmployeeDetails2(Map<String,dynamic>employeeInofMap,String id)async{
    return await FirebaseFirestore.instance.collection("Employee2").doc(id).set(employeeInofMap);
  } 

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async{
    return await FirebaseFirestore.instance.collection("Employee2").snapshots();
  }

  Future UpdateEmployeeDetails(String id,Map<String,dynamic>updateInfo) async{
    return await FirebaseFirestore.instance.collection("Employee2").doc(id).update(updateInfo);
  }

    Future deleteEmployee(String id) async{
    return await FirebaseFirestore.instance.collection("Employee2").doc(id).delete();;
  }

// ----------------------------------- user -----------------------------------
  Future addNewUser(Map<String,dynamic>userInOfMap,String id)async{
    return await FirebaseFirestore.instance.collection("User").doc(id).set(userInOfMap);
  } 

  Future<Stream<QuerySnapshot>> getUserDetails()async{
    return await FirebaseFirestore.instance.collection("User").snapshots();
  }

  Future UpdateUserDetails(String id,Map<String,dynamic>updateinfo) async{
    return await FirebaseFirestore.instance.collection("User").doc(id).update(updateinfo);
  }

  Future deleteUser(String id) async{
    return await FirebaseFirestore.instance.collection("User").doc(id).delete();
  }
}