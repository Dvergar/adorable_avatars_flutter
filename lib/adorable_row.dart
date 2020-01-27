import 'package:flutter/material.dart';

class AdorableRow extends StatefulWidget {
  final Widget child;
  final String title;
  final String title2;
  final bool selected;
  final VoidCallback onSelect;

  AdorableRow(
      {Key key,
      @required this.child,
      @required this.title,
      @required this.onSelect,
      this.title2,
      this.selected = false})
      : super(key: key);

  @override
  _AdorableRowState createState() => _AdorableRowState();
}

class _AdorableRowState extends State<AdorableRow> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        widget.onSelect();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff2D4359).withOpacity(0.9),
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xff385F71)),
          ),
        ),
        height: 120,
        child: Row(
          children: <Widget>[
            AnimatedOpacity(
              opacity: widget.selected ? 1.0 : 0.0,
              duration: Duration(milliseconds: 100),
              child: Container(
                color: Color(0xffE14283),
                width: 6,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 25, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              color: Color(0xff8A97A3),
                              fontSize: 15,
                              fontFamily: "Proxima"),
                        ),
                        widget.title2 == null
                            ? Container()
                            : Text(
                                ' ${widget.title2} px',
                                style: TextStyle(
                                    height: 0.7,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Proxima"),
                              ),
                      ],
                    ),
                    Expanded(child: widget.child)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
