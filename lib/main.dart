import 'package:adorable_avatars_flutter/adorable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transparent_image/transparent_image.dart';
import 'avatar_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adorable avatars',
      theme: ThemeData(
          fontFamily: "Proxima",
          primarySwatch: Colors.blue,
          canvasColor: Color(0xffc98bad)),
      home: MyHomePage(title: 'Adorable avatars'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int size = 285;
  TextEditingController identifierController;

  @override
  void initState() {
    super.initState();
    identifierController = new TextEditingController(text: 'abott@adorable.io');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/demo-bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder(
                stream: avatarBloc.stream,
                initialData:
                    'https://api.adorable.io/avatars/123/abott@adorable.png',
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return Text("nope");
                  return FadeInImage.memoryNetwork(
                    height: 300,
                    width: 300,
                    placeholder: kTransparentImage,
                    image: snapshot.data,
                  );
                },
              ),
            ),
            AdorableRow(
              title: "IDENTIFIER",
              child: TextField(
                controller: identifierController,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Arial", fontSize: 18),
                decoration: InputDecoration.collapsed(hintText: "enter text"),
                onChanged: (newIdentifier) {
                  avatarBloc.updateIdentifier(newIdentifier);
                },
              ),
            ),
            AdorableRow(
              title: 'SIZE',
              title2: size.toString(),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color(0xff667382),
                  inactiveTrackColor: Color(0xff667382),
                  trackHeight: 6.3,
                  thumbColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  trackShape: CustomTrackShape(),
                ),
                child: Slider(
                  value: size.toDouble(),
                  max: 300,
                  onChanged: (newSize) {
                    setState(() => size = newSize.round());
                  },
                  onChangeEnd: (newSize) {
                    avatarBloc.updateSize(newSize.round());
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      color: Colors.white,
                      child: StreamBuilder(
                        stream: avatarBloc.stream,
                        initialData: "ok",
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) return Text("Loading");
                          return SelectableText.rich(TextSpan(
                              style: TextStyle(fontFamily: 'Source Code Pro'),
                              children: [
                                TextSpan(
                                    text: 'https://api.adorable.io/avatars/'),
                                TextSpan(
                                    text: avatarBloc.size.toString(),
                                    style: TextStyle(color: Color(0xffe14283))),
                                TextSpan(text: '/'),
                                TextSpan(
                                    text: avatarBloc.identifier,
                                    style: TextStyle(color: Color(0xffe14283)))
                              ]));
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Material(
                        color: Color(0xff6ED8D6),
                        child: Builder(
                          builder: (context) => IconButton(
                            icon: Icon(Icons.content_copy),
                            tooltip: 'Copy to clipboard',
                            onPressed: () {
                              Clipboard.setData(
                                  new ClipboardData(text: "coucou"));
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      new Text("Link copied to clipboard")));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 17),
            FlatButton(
              color: Color(0xffE14283),
              textColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Download avatar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
