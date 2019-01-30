import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  
   Function(String) _callbackHandling;
  ButtonsWidget( this._callbackHandling) : super();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var cellHeigth = constraints.maxHeight / 5;
        var cellWidth = constraints.maxWidth / 4;
        var aspectRatio = cellWidth / cellHeigth;
        var list = _createRow(["AC", "", "%", "/"], this._callbackHandling);

        list.addAll(_createRow(["7", "8", "9", "X"], _callbackHandling));
        list.addAll(_createRow(["4", "5", "6", "-"], _callbackHandling));
        list.addAll(_createRow(["1", "2", "3", "+"], _callbackHandling));
        list.addAll(_createRow(["0", "", ".", "="], _callbackHandling));

        return GridView.count(
          crossAxisCount: 4,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          childAspectRatio: aspectRatio,
          children: list,
        );
      },
    );
  }

  List<Widget> _createRow(List<String> names, Function(String) callback) {
    var list = List<Widget>();
    for (var item in names) {
      if (item.isEmpty) {
        list.add(Container(color: Colors.grey[200],));
      } else {
        list.add(
          FlatButton(
            child: Text(item),
            onPressed: () {
              callback(item);
            },
          ),
        );
      }
    }
    return list;
  }
}
