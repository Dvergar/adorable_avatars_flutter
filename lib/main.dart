import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'avatar_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adorable avatars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  double size = 285;
  TextEditingController identifierController;

 @override
  void initState() {
    super.initState();
    identifierController = new TextEditingController(text: 'Initial value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
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
            TextField(
              controller: identifierController,
              style: TextStyle(color: Colors.red),
              decoration: InputDecoration(hintText: "enter text"),
              onChanged: (newIdentifier) {
                avatarBloc.updateIdentifier(newIdentifier);
              },
            ),
            Slider(
              value: size,
              max: 300,
              onChanged: (newSize) {
                setState(() => size = newSize);
              },
              onChangeEnd: (newSize) {
                avatarBloc.updateSize(newSize.round());
              },
            )
          ],
        ),
      ),
    );
  }
}
