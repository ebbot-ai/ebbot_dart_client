class ButtonData {
  final String buttonId;
  final String label;
  ButtonData({
    required this.buttonId,
    required this.label,
  }) {
    _validate();
  }

  void _validate() {
    if (buttonId.isEmpty) {
      throw ArgumentError('buttonId cannot be empty');
    }
    if (label.isEmpty) {
      throw ArgumentError('label cannot be empty');
    }
  }
}
