
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferences prefs;
  Storage(SharedPreferences sharedPreferencesInstance): prefs = sharedPreferencesInstance;

  double? getCanvasWidth() => prefs.getDouble('canvasWidth');
  Future<bool> setCanvasWidth({ required double canvasWidth}) {
    return prefs.setDouble('canvasWidth', canvasWidth);
  }

  double? getCanvasHeight() => prefs.getDouble('canvasHeight');
  Future<bool> setCanvasHeight({ required double canvasHeight}) {
    return prefs.setDouble('canvasHeight', canvasHeight);
  }

  double? getPenStrokeWidth() => prefs.getDouble('penStrokeWidth');
  Future<bool> setPenStrokeWidth({ required double penStrokeWidth}) {
    return prefs.setDouble('penStrokeWidth', penStrokeWidth);
  }

  String? getImageName() => prefs.getString('imageName');
  Future<bool> setImageName({ required String imageName}) {
    return prefs.setString('imageName', imageName);
  }
}