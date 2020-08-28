import 'package:flutter/material.dart';
import 'package:ixiamobile_application/Components/separator_list_item.dart';

import 'editAccount.dart';

class Account extends StatelessWidget {
  Widget _buildSettingsList(BuildContext context) {
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
            onTap: () {
            },
          ),
        ),
        SeparatorListItem(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.exit_to_app),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            title: Text('Logout'),
            subtitle: Text('Sign out of this device'),
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
                        onPressed: () {},
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
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('res/images/unknown.jpg'),
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
                                'Alaa Ghader',
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
          _buildSettingsList(context),
        ],
      ),
    );
  }
}
