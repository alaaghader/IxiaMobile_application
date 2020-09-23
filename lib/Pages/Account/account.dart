import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:ixiamobile_application/Components/separator_list_item.dart';
import 'package:ixiamobile_application/Pages/AuthenticationUI/signin.dart';
import 'package:ixiamobile_application/Pages/AuthenticationUI/signup.dart';
import 'package:ixiamobile_application/Store/user_store.dart';
import 'package:provider/provider.dart';
import 'editAccount.dart';

class Account extends StatelessWidget {
  String typeName(String firstName, String lastName) {
    if (firstName == null || lastName == null) {
      return 'ixia user'.toUpperCase();
    } else {
      return firstName.toUpperCase() + " " + lastName.toUpperCase();
    }
  }

  Widget _buildSettingsList(BuildContext context, UserStore userStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SeparatorListItem(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person_outline),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            title: Text('Profile Settings'),
            subtitle: Text('Profile, privacy options'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAccount(),
                ),
              );
            },
          ),
        ),
        SeparatorListItem(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.help_outline),
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            title: Text('Help'),
            subtitle: Text('FAQ, contact us, privacy policy'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {},
          ),
        ),
        SeparatorListItem(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.exit_to_app),
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            title: Text('Logout'),
            subtitle: userStore.isLoggedIn && userStore.profile != null
                ? Text(
                    "Logged in as ${userStore.profile.email}",
                    style: TextStyle(color: Colors.grey),
                  )
                : Text('Sign out of this device'),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () async {
                          await Provider.of<UserStore>(context, listen: false)
                              .logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Ixia',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Observer(
        builder: (context) {
          var userStore = Provider.of<UserStore>(context);
          var profileFuture = userStore.profile != null || !userStore.isLoggedIn
              ? Future.value(userStore.profile)
              : userStore.loadProfile();
          return FutureBuilder<User>(
            future: profileFuture,
            builder: (context, snapshot) {
              if (userStore.isLoggedIn) {
                return ListView(
                  children: <Widget>[
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          userStore.profile.profilePicture == null
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('res/images/unknown.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  width: 100.0,
                                  height: 100.0,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: new NetworkImage(
                                          'http://alaaghader-001-site1.gtempurl.com/api/Profile/get/${userStore.profile.profilePicture}'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  width: 100.0,
                                  height: 100.0,
                                ),
                          SizedBox(width: 16.0),
                          Flexible(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        typeName(userStore.profile.firstName,
                                            userStore.profile.lastName),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //quickAccessList,
                    Divider(),
                    _buildSettingsList(context, userStore),
                  ],
                );
              } else {
                return Center(
                  child: FlatButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signin(),
                        ),
                      );
                    },
                    icon: Icon(Icons.lock),
                    label: Text("Please Login To Enter To This Page"),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
