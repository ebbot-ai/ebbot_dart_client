class Notification {
  final String _title;
  final String _text;
  final bool _isDismissable;

  String get title => _title;
  String get text => _text;

  Notification(this._title, this._text, this._isDismissable);
}
