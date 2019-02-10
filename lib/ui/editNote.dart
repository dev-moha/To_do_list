


import 'package:flutter/material.dart';
import 'package:noteapp/model/note.dart';
import 'package:noteapp/utils/database_helper.dart';
class Editnote extends  StatefulWidget {
  final Note note;
  Editnote(this.note);
  
  @override
  _EditnoteState createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  DatabaseHelper db = new DatabaseHelper();
   TextEditingController _titleController;
  TextEditingController _descriptionController;
 
  @override
  void initState() {
    super.initState();
 
    _titleController = new TextEditingController(text: widget.note.title);
    _descriptionController = new TextEditingController(text: widget.note.description);
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
              controller: _titleController,
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

              controller: _descriptionController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.keyboard,color: colorbar,size: 50.0,),
                labelText: "enter description",
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
      child: new Text("Update",style: TextStyle(fontSize: 25.0),),
       color: iconColor,
      onPressed: (){
   if (widget.note.id != null) {
                  db.updateNote(Note.fromMap({
                    'id': widget.note.id,
                    'title': _titleController.text,
                    'description': _descriptionController.text
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                }


      
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
         final iconColor =HexColor("E3AC1B");

   return new AppBar(
     backgroundColor: colorbar,
     title: new Center(child: new Text("Update Note",style: TextStyle(
    fontSize: 30.0,
    color:iconColor ,

    fontStyle: FontStyle.italic,
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