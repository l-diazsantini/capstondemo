import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _xAxis =
          prefs.getStringList('ff_xAxis')?.map(double.parse).toList() ?? _xAxis;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<double> _xAxis = [
    0.0,
    1.57,
    3.14,
    4.71,
    6.28,
    0.0,
    -1.57,
    -3.14,
    -4.71,
    -6.28
  ];
  List<double> get xAxis => _xAxis;
  set xAxis(List<double> value) {
    _xAxis = value;
    prefs.setStringList('ff_xAxis', value.map((x) => x.toString()).toList());
  }

  void addToXAxis(double value) {
    _xAxis.add(value);
    prefs.setStringList('ff_xAxis', _xAxis.map((x) => x.toString()).toList());
  }

  void removeFromXAxis(double value) {
    _xAxis.remove(value);
    prefs.setStringList('ff_xAxis', _xAxis.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromXAxis(int index) {
    _xAxis.removeAt(index);
    prefs.setStringList('ff_xAxis', _xAxis.map((x) => x.toString()).toList());
  }

  void updateXAxisAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    _xAxis[index] = updateFn(_xAxis[index]);
    prefs.setStringList('ff_xAxis', _xAxis.map((x) => x.toString()).toList());
  }

  void insertAtIndexInXAxis(int index, double value) {
    _xAxis.insert(index, value);
    prefs.setStringList('ff_xAxis', _xAxis.map((x) => x.toString()).toList());
  }

  List<double> _yAxis = [0.0, 1.0, 0.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0];
  List<double> get yAxis => _yAxis;
  set yAxis(List<double> value) {
    _yAxis = value;
  }

  void addToYAxis(double value) {
    _yAxis.add(value);
  }

  void removeFromYAxis(double value) {
    _yAxis.remove(value);
  }

  void removeAtIndexFromYAxis(int index) {
    _yAxis.removeAt(index);
  }

  void updateYAxisAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    _yAxis[index] = updateFn(_yAxis[index]);
  }

  void insertAtIndexInYAxis(int index, double value) {
    _yAxis.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
