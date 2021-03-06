import 'dart:io';

class AdManager {


 static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544~4354546703";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544~2594085930";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8865242552";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4339318960";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  
  // static String get appId {
  //   if (Platform.isAndroid) {
  //     return " ca-app-pub-5647553467350873~6699529354";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-5647553467350873~7166433210";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-5647553467350873/3610331585";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-5647553467350873/4540269875";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>";
  //   } else if (Platform.isIOS) {
  //     return "<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
  //   } else if (Platform.isIOS) {
  //     return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
  //   } else {
  //     throw new UnsupportedError("Unsupported platform");
  //   }
  // }
}