import 'dart:async';

import 'package:flutter/material.dart';


class LearnStream extends StatefulWidget {
  const LearnStream({super.key});

  @override
  State<LearnStream> createState() => _LearnStreamState();
}

class _LearnStreamState extends State<LearnStream> {

  StreamController _controller =  StreamController();

  assStreamData() async{
    for(int i =0;i<10;i++){
      await Future.delayed(Duration(seconds: 2));
      _controller.sink.add(i);
    }
  }

    assStreamData2() async*{
    for(int i =0;i<20;i++){
      await Future.delayed(Duration(seconds: 2));
      yield i;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assStreamData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Stream",style: TextStyle(color: Colors.blue,fontSize: 24.0,fontWeight: FontWeight.bold),),
      ),
      body: StreamBuilder(
        stream: assStreamData2(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"),);
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator.adaptive();
          }

              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Center(
                    child:  Text("${snapshot.data}",style: TextStyle(color: Colors.black, fontSize: 24.0,fontWeight: FontWeight.bold),),
                  ),
                  ],
                ),
              );
        }
      ),
    );
  }
}
