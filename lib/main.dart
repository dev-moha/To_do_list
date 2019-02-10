import 'package:flutter/material.dart';
import 'package:noteapp/ui/notelist.dart';
void main(){
  runApp(
    Myapp(),
  );
}


class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Simple To do List",
      home: Notelist(),
    );
  }

}
