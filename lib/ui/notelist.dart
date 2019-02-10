
import 'package:flutter/material.dart';
import 'package:noteapp/ui/addNote.dart';
import 'package:async/async.dart';
import 'package:noteapp/utils/database_helper.dart';
import 'package:noteapp/model/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:noteapp/ui/editNote.dart';


class Notelist  extends  StatefulWidget {
  @override
  _NotelistState createState() => _NotelistState();
}

class _NotelistState extends State<Notelist> {
    DatabaseHelper db = new DatabaseHelper();
  List<Note> items = new List(); 
   final bg =  HexColor("333333");
   final colorbar = HexColor("1F2C3D"); 
   final iconColor =HexColor("E3AC1B");
 

  @override
  void initState() {
    super.initState();
 
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }


  @override

  Widget build(BuildContext context) {
      final colorbar = HexColor("1F2C3D"); 
   final iconColor =HexColor("E3AC1B");
    return Scaffold(
      backgroundColor: bg,
      appBar: new AppBar(
     leading:Icon(Icons.menu,size: 35.0,color: iconColor,),
     backgroundColor: colorbar,
     title: new Center(child: new Text("To Do List",style: TextStyle(
    fontSize: 30.0,
    fontStyle: FontStyle.italic,
    color: iconColor,
     ),),),
     actions: <Widget>[
      new IconButton(
         icon: Icon(Icons.add,size: 35.0,color: iconColor,),
 onPressed: () => _createNewNote(context),

          
       ),
     ],

  ),

     body: new Container(
       child: new ListView.builder(
         itemCount: items.length,
         itemBuilder: (context,position){
            return new Card(
              color: iconColor,
          
                  child:ListTile(
                    
                title: new Text("${items[position].title}"
                ,style: TextStyle(color:colorbar,
                fontSize: 25.0),),
                subtitle: new Text("${items[position].description}"
                 ,style: TextStyle(color: Colors.black,)),
                 trailing: new IconButton(
                   icon: Icon(Icons.delete,color:colorbar,size: 28.0,),
                   onPressed: ()=>_deletenote(context,items[position], position),
                 ),
                 onTap: ()=>_updatenote(context,items[position]),
              ) ,
            
          
            );
         }
       ),
     ), 
    );



  }
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Addnote(Note('', ''))),
    );
 
    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }


void _updatenote(BuildContext context,Note note)async{
  String result =await Navigator.push(context, 
  MaterialPageRoute(builder: (context)=>Editnote(note)));
    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
}


void _deletenote(BuildContext context,Note note,int position)async{
  db.deleteNote(note.id).then((notes){
    setState(() {
          items.removeAt(position);
        });
  });
 
}


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











