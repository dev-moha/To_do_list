


import 'package:flutter/material.dart';
import 'package:noteapp/model/note.dart';
import 'package:noteapp/utils/database_helper.dart';
class Addnote extends  StatefulWidget {
final Note note;
Addnote(this.note);



  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  DatabaseHelper db = new DatabaseHelper();
  List<Note> items = new List();
	TextEditingController titleController ;
	TextEditingController descriptionController;
 

  @override

   void initState() {
    super.initState();
 
    titleController = new TextEditingController(text: widget.note.title);
    descriptionController = new TextEditingController(text: widget.note.description);
  }


  Widget build(BuildContext context) {
 final bg =  HexColor("333333");
   final colorbar = HexColor("1F2C3D"); 
   final iconColor =HexColor("E3AC1B");
    return Scaffold(
      backgroundColor: bg,
      appBar: myappbar(),
      body: new Container(           
child: ListView(
          children: <Widget>[

            Padding(padding: EdgeInsets.only(top: 140.0),),
           new Container(
             decoration: BoxDecoration(
               color: Colors.white,
                border: Border.all(color: colorbar,width: 3.0),
             ),
             child:  TextField(
              controller: titleController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit,color: colorbar,size: 50.0,),
                labelText: "enter your title",
                labelStyle: TextStyle(color: colorbar),
                
              
              ),
            ),
           ),
             const Divider(
        height: 1.0,
      ),
                  Padding(padding: EdgeInsets.only(top: 50.0),),

    
        new Container(
             decoration: BoxDecoration(
               color: Colors.white,
                border: Border.all(color: colorbar,width: 3.0),
             ),
             child:  TextField(
               controller: descriptionController,    
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.keyboard,color: colorbar,size: 50.0,),
                labelText: "enter your Description",
                labelStyle: TextStyle(color: colorbar),
                
              
              ),
            ),
           ),
                    const Divider(
        height: 1.0,
      ),
            Padding(padding: EdgeInsets.only(top: 50.0),),

  new  Container(

  width: 50.0,
  height: 60.0,  
  decoration: BoxDecoration(
     border: Border.all(color: colorbar,width: 3.0),

  ), 
 
    child: new RaisedButton(
      child: new Text("add New",style: TextStyle(fontSize: 25.0),),
            color: iconColor,
      onPressed: (){

          db.insertNote(Note(titleController.text, descriptionController.text)).then((_){
          
          
          
        Navigator.pop(context,'save');



      
            });

     

      }
      
      
    ),
  ),         
  
   ],
        ),
      ),

      
    );
  }
}


//  app bar


 myappbar(){
   final colorbar = HexColor("1F2C3D"); 
   final iconColor =HexColor("E3AC1B");   return new AppBar(
     backgroundColor: colorbar,
     title: new Center(child: new Text("Add New Note",style: TextStyle(
    fontSize: 30.0,
    fontStyle: FontStyle.italic,
    color: iconColor,
     ),),),
   

   );

}






class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}