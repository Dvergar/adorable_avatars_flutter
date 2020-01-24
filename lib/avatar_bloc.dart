import 'dart:async';

class AvatarBloc {
  int size = 285;
  String identifier = "abott@adorable.io";

  final urlController =
      StreamController.broadcast(); // create a StreamController

  Stream get stream => urlController.stream; // create a getter for our stream

  void updateUrl() {
    urlController.sink
        .add('https://api.adorable.io/avatars/$size/$identifier.png');
  }

  void updateSize(int newSize) {
    this.size = newSize;
    updateUrl();
  }

  void updateIdentifier(String newIdentifier) {
    this.identifier = newIdentifier;
    updateUrl();
  }

  void dispose() {
    urlController.close(); // close our StreamController
  }
}

final avatarBloc = AvatarBloc();
