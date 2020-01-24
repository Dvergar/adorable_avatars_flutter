import 'package:flutter/material.dart';

class AdorableRow extends StatefulWidget {
  final Widget child;
  final String title;

  AdorableRow({Key key, @required this.child, @required this.title})
      : super(key: key);

  @override
  _AdorableRowState createState() => _AdorableRowState();
}

class _AdorableRowState extends State<AdorableRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff2D4359),
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xff385F71)),
        ),
      ),
      height: 120,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Color(0xffE14283),
            width: 10,
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top:21.0),
          //     child: ListTile(
          //       title: Text(widget.title, style: TextStyle(color:Color(0xff8A97A3),  fontSize: 15, fontFamily: "Proxima"),),
          //       subtitle: widget.child,
          //     ),
          //   ),
          // ),

          Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14,25,14,14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                        color: Color(0xff8A97A3),
                        fontSize: 15,
                        fontFamily: "Proxima"),
                ),
                Expanded(child: widget.child)
              ],
            ),
                      ),
          )
        ],
      ),
    );
  }
}
