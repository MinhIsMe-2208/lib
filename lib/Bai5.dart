import 'dart:math';
import 'package:flutter/material.dart';
class ChangeColorApp extends StatefulWidget {
   const ChangeColorApp({super.key});
@override
  State<ChangeColorApp> createState() => _ChangeColorAppState();
}
class _ChangeColorAppState extends State<ChangeColorApp> {
    Color bgColor = Colors.green;
    List<String> listText = ["Red","Green","Blue","Yellow","Purple"];
    String bgColorString = "Green";
    List<Color> listColor = [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple];
    
    void _changeColor(){
      setState(() {
        var random = Random();
        var r = random.nextInt(listColor.length);
        bgColor = listColor[r];
        bgColorString = listText[r];
      });
}
    void _resetColor(){
      setState(() {
        bgColor = Colors.black54;
        bgColorString = "He he he hiii";
      });
    }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        leading: Icon(Icons.color_lens_outlined),
        title: Text("Change Color App",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 81, 81, 81),
        foregroundColor: Colors.white,
        ),
      body: Container(
        decoration: BoxDecoration(
          color: bgColor
         ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100,),
          Text((bgColorString),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
          const SizedBox(height: 300,),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
              //   onPressed: () {
              //   setState(() {
              //   bgColor = Colors.red;
              //  });
              //  },
              onPressed: _changeColor,
               child: Text("Change Color"),),
          const SizedBox(width: 14,),
              ElevatedButton(
               onPressed: _resetColor,
               child: Text("Reset Color"),)
            ],
            
            
          )
        ],
      ),
      ),
    );
  }
}