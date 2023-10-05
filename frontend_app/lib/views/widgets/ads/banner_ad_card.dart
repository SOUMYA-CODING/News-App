import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsCard extends StatelessWidget {
  const BannerAdsCard({
    super.key,
    required this.bannerAd,
  });

  final BannerAd? bannerAd;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, index) => Container(
        margin: EdgeInsets.only(bottom: 2.0.hp),
        width: bannerAd!.size.width.toDouble(),
        height: bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: bannerAd!),
      ),
    );
  }
}
