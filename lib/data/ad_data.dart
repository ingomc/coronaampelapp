import 'dart:io';

class AdData {
  static final String testAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  static final String nativeAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-6534315507576320/8059167232'
      : 'ca-app-pub-6534315507576320/3145945425';

  static final String rewardedAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-6534315507576320/4474863605'
      : 'ca-app-pub-6534315507576320/7292598634';
}
