import 'package:chatapp/screens/ad_manager.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  BannerAd _bannerAd;

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(
        anchorType: AnchorType.top,
        anchorOffset: MediaQuery.of(context).size.height * 0.50,
      );
  }

  @override
  void initState() {
    initAddMob();
    super.initState();
  }

  initAddMob() async {
    await FirebaseAdMob.instance.initialize(appId: AdManager.appId);
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );

    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: deviceHeight * .5,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text('Button 1'),
                onPressed: () {},
              ),
            ),
            Container(
              height: deviceHeight * .5,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text('Button 2'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
