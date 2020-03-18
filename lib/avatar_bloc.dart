import 'dart:async';

class AvatarBloc {
  int size = 285;
  String identifier = "abott@adorable.io";
  String url = "";

  final urlController =
      StreamController.broadcast();

  Stream get stream => urlController.stream;

  void updateUrl() {
    this.url = 'https://api.adorable.io/avatars/$size/$identifier.png';
    urlController.sink.add(url);
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
    urlController.close();
  }
}

final avatarBloc = AvatarBloc();
