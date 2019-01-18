import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:my_softball_team/globals.dart' as globals;

class EmailCard extends StatefulWidget {
  final DocumentSnapshot emailSnap;

  const EmailCard({
    this.emailSnap,
  });

  @override
  _EmailCardState createState() => _EmailCardState();
}

class _EmailCardState extends State<EmailCard> {
  TextEditingController _editEmailAddressFieldContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        leading: Icon(OMIcons.email),
        title: Text(widget.emailSnap.documentID),
        trailing: SizedBox(
          width: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(OMIcons.edit, color: Colors.black,),
                onPressed: (){
                  String selectedEmail = widget.emailSnap.documentID;
                  showDialog(
                    context: context,
                    builder: (_) => SimpleDialog(
                      title: Text("Edit Email Address"),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ListTile(
                            title: TextField(
                              controller: _editEmailAddressFieldContoller,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: selectedEmail,
                                prefixIcon: Icon(OMIcons.email),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 16.0),
                              child: FlatButton(
                                child: Text("Save", style: TextStyle(color: Colors.indigo),),
                                onPressed: (){
                                  String updatedEmail = _editEmailAddressFieldContoller.text;
                                  CollectionReference addressBook = Firestore.instance.collection("Teams").document(globals.teamName).collection("EmailList");
                                  addressBook.document(widget.emailSnap.documentID).delete();
                                  addressBook.document(updatedEmail).setData({});
                                  _editEmailAddressFieldContoller.text = "";
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(OMIcons.delete, color: Colors.black,),
                onPressed: (){
                  CollectionReference addressBook = Firestore.instance.collection("Teams").document(globals.teamName).collection("EmailList");
                  addressBook.document(widget.emailSnap.documentID).delete();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
