import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_softball_team/globals.dart' as globals;

class EmailList extends StatefulWidget {
  @override
  _EmailListState createState() => _EmailListState();
}

class _EmailListState extends State<EmailList> {
  List<Widget> emailFields = [
    
  ];

  TextEditingController _emailAddressFieldContoller = TextEditingController();
  TextEditingController _editEmailAddressFieldContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Email List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Teams").document(globals.teamName).collection("EmailList").snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData == false){
            return Container();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index){
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(OMIcons.email),
                        title: Text(ds.documentID),
                        trailing: SizedBox(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(OMIcons.edit, color: Colors.black,),
                                onPressed: (){
                                  String selectedEmail = ds.documentID;
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
                                                  addressBook.document(ds.documentID).delete();
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
                                  addressBook.document(ds.documentID).delete();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.0,
                        color: Colors.grey,
                      )
                    ],
                  );
                }
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add Email"),
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              title: Text("Add email"),
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: TextField(
                              controller: _emailAddressFieldContoller,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(OMIcons.email),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: FlatButton(
                                  child: Text("Save", style: TextStyle(color: Colors.indigo),),
                                  onPressed: (){
                                    String emailAddress = _emailAddressFieldContoller.text;
                                    CollectionReference addressBook = Firestore.instance.collection("Teams").document(globals.teamName).collection("EmailList");
                                    addressBook.document(emailAddress).setData({});
                                    _emailAddressFieldContoller.text = "";
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
