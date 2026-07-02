import 'package:flutter/material.dart';

/// Drives the "create post" composer. Seeds a caption and a selected gradient
/// in the constructor so the preview is populated on the first frame.
class CreatePostViewModel extends ChangeNotifier {
  CreatePostViewModel() {
    _caption =
        'Fim de tarde perfeito na orla, a luz dourada de hoje estava surreal.';
  }

  static const List<List<Color>> gradients = <List<Color>>[
    <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
    <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
    <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
    <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
    <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
    <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
  ];

  late String _caption;
  int _selectedGradient = 0;
  bool _locationOn = true;
  bool _disableComments = false;
  bool _hideLikes = false;

  String get caption => _caption;
  int get selectedGradient => _selectedGradient;
  List<Color> get gradient => gradients[_selectedGradient];
  bool get locationOn => _locationOn;
  bool get disableComments => _disableComments;
  bool get hideLikes => _hideLikes;
  bool get canPublish => _caption.trim().isNotEmpty;

  void setCaption(String value) {
    _caption = value;
    notifyListeners();
  }

  void selectGradient(int index) {
    _selectedGradient = index;
    notifyListeners();
  }

  void setLocation(bool value) {
    _locationOn = value;
    notifyListeners();
  }

  void setDisableComments(bool value) {
    _disableComments = value;
    notifyListeners();
  }

  void setHideLikes(bool value) {
    _hideLikes = value;
    notifyListeners();
  }
}
