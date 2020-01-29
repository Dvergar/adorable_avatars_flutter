import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Credits extends StatelessWidget {
  const Credits({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body1;
    final TextStyle linkStyle =
        themeData.textTheme.body1.copyWith(color: themeData.accentColor);

    return SimpleDialog(
      title: new Text("Credits"),
      contentPadding: EdgeInsets.all(20),
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  style: aboutTextStyle,
                  text:
                      'This avatar generator is based on the Adorable Avatars service '),
              _LinkTextSpan(
                style: linkStyle,
                url: 'http://avatars.adorable.io',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.\n\nThis app is open-source and available at ',
              ),
              _LinkTextSpan(
                style: linkStyle,
                url: 'https://github.com/Dvergar/adorable_avatars_flutter',
                text: 'the app github repo',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.\n\n'
                    'Art has been done by ',
              ),
              _LinkTextSpan(
                style: linkStyle,
                url: 'https://dribbble.com/missingdink',
                text: 'Kelly Rauwerdink',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.',
              )
            ],
          ),
        ),
      ],
    );
  }
}

// URL LAUNCHER
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// HELPER FOR LINKS IN TEXTSPANS
class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchURL(url);
              });
}
