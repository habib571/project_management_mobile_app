import '../helpers/screen_configuraton.dart';

extension ScreenExtensions on num {
  static final ScreenConfiguration _screenUtility = ScreenConfiguration();

  double get w => _screenUtility.setWidth(this);

  double get h => _screenUtility.setHeight(this);
}
