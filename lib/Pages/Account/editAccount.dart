import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:intl/intl.dart';
import 'package:ixiamobile_application/Failures/failure.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class EditAccount extends StatefulWidget {
  @override
  EditAccountState createState() => EditAccountState();
}

class EditAccountState extends State<EditAccount>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  final _birthDateController = TextEditingController();
  Future<File> file;
  String base64Image;
  File tmpFile;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Observer(
        builder: (context) {
          var userStore = Provider.of<UserStore>(context);
          var profileFuture = userStore.profile != null
              ? Future.value(userStore.profile)
              : userStore.loadProfile();

          if (userStore.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder(
            future: profileFuture,
            builder: (_, snapshot) {
              var profile = userStore.profile;
              _birthDateController.value = TextEditingValue(
                text: _formatDate(profile.birthDate),
              );
              return _editAccountWidget(profile, userStore, context);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons(User user, UserStore store, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: new Container(
                child: new RaisedButton(
                  child: new Text(
                    'Save',
                  ),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      _status = !_status;
                      FocusScope.of(context).requestFocus(new FocusNode());
                      try {
                        if (tmpFile == null) {
                          tmpFile = new File.fromUri(Uri.http(
                              'http://alaaghader-001-site1.gtempurl.com/api/Profile/get/${store.profile.profilePicture}',
                              ""));
                        }
                        store.updateProfile(user.firstName, user.middleName,
                            user.lastName, user.address);
                        Navigator.pop(context);
                      } on Failure catch (e) {
                        Scaffold.of(context).showSnackBar(e.toSnackBar());
                      }
                    });
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget showImage(UserStore store) {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          print(tmpFile);
          store.updateProfilePicture(tmpFile);
          return GestureDetector(
            child: new Container(
              width: 140.0,
              height: 140.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: new FileImage(snapshot.data),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                file = ImagePicker.pickImage(source: ImageSource.gallery);
              });
            },
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else if (store.profile.profilePicture != null) {
          return GestureDetector(
            child: new Container(
              width: 140.0,
              height: 140.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: new NetworkImage(
                      'http://alaaghader-001-site1.gtempurl.com/api/Profile/get/${store.profile.profilePicture}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                file = ImagePicker.pickImage(source: ImageSource.gallery);
              });
            },
          );
        } else {
          return GestureDetector(
            child: new Container(
              width: 140.0,
              height: 140.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: AssetImage('res/images/unknown.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                file = ImagePicker.pickImage(source: ImageSource.gallery);
              });
            },
          );
        }
      },
    );
  }

  Widget _editAccountWidget(User user, UserStore store, BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: new Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        showImage(store),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 90.0, right: 100.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 25.0,
                            child: new Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          new Container(
            color: Color(0xFFFFFFFF),
            child: Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _status ? _getEditIcon() : new Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'First Name',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your first name",
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                            initialValue: user.firstName,
                            onChanged: (v) => user.firstName = v,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Middle Name',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your middle name",
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                            initialValue: user.middleName,
                            onChanged: (v) => user.middleName = v,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Last Name',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your last name",
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                            initialValue: user.lastName,
                            onChanged: (v) => user.lastName = v,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter your Adress",
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                            initialValue: user.address,
                            onChanged: (v) => user.address = v,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'BirthDay',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Flexible(
                          child: new GestureDetector(
                            //onTap: () => _showBirthDatePicker(context, user),
                            behavior: HitTestBehavior.opaque,
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: _birthDateController,
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  hintText: 'dd/mm/yyyy',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  !_status
                      ? _getActionButtons(user, store, context)
                      : new Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    if (date == null) {
      return "";
    }
    return DateFormat.yMMMMd().format(date);
  }

  Future _showBirthDatePicker(BuildContext context, User profile) async {
    profile.birthDate = (await showDatePicker(
      context: context,
      initialDate: profile.birthDate ?? DateTime.now(),
      firstDate: DateTime.parse('0001-01-01'),
      lastDate: DateTime.now(),
    ));
    _birthDateController.value = TextEditingValue(
      text: _formatDate(profile.birthDate),
    );
  }
}
