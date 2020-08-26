import 'package:flutter/material.dart';

class SeparatorListItem extends StatelessWidget {
  final Widget child;

  const SeparatorListItem({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
          subtitle1: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      child: Column(
        children: <Widget>[
          child,
          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(200, 200, 200, 0.8),
                          width: 0.4))),
            ),
          ),
        ],
      ),
    );
  }
}
