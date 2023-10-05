import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/helper/ad_helper.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/controller/dashboard/tabs/home_tab_controller.dart';
import 'package:frontend_app/routes/route_names.dart';
import 'package:frontend_app/views/widgets/ads/banner_ad_card.dart';
import 'package:frontend_app/views/widgets/card/big_news_card.dart';
import 'package:frontend_app/views/widgets/card/small_news_card.dart';
import 'package:frontend_app/views/widgets/common/custom_headline_view.dart';
import 'package:frontend_app/views/widgets/common/custom_search_field.dart';
import 'package:frontend_app/views/widgets/headers/home_header.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  BannerAd? smallBannerAd;
  List<BannerAd?> largeBannerAds = [];

  final controller = Get.put(HomeTabController());
  final TextEditingController ct = TextEditingController();
  final int numberOfArticles = 40;

  @override
  void initState() {
    super.initState();

    int numberOfLargeBanners = (numberOfArticles / 4).ceil();

    for (int i = 0; i < numberOfLargeBanners; i++) {
      final bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.largeBanner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              largeBannerAds[i] = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (ad, err) {
            if (kDebugMode) {
              print('Failed to load a banner ad: ${err.message}');
            }
            ad.dispose();
          },
        ),
      );

      bannerAd.load();
      largeBannerAds.add(bannerAd);
    }

    smallBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            smallBannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          if (kDebugMode) {
            print('Failed to load a banner ad: ${err.message}');
          }
          ad.dispose();
        },
      ),
    );

    smallBannerAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
    smallBannerAd?.dispose();
    for (var bannerAd in largeBannerAds) {
      bannerAd?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          const HomeHeader(),
          SizedBox(height: 3.0.hp),

          // Search Field
          CustomSearchField(ct: ct),
          SizedBox(height: 2.0.hp),

          // Breaking News
          // const BreakingNewsCard(),
          // SizedBox(height: 2.0.hp),

          // Featured News
          const CustomHeadlineView(
              title: "Featured", routePath: RouteName.loginScreen),
          SizedBox(height: 1.0.hp),
          SizedBox(
            width: double.infinity,
            height: 255,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => const BigNewsCard(),
            ),
          ),
          SizedBox(height: 3.0.hp),

          if (smallBannerAd != null) BannerAdsCard(bannerAd: smallBannerAd),

          // Trending News
          const CustomHeadlineView(
              title: "Trending", routePath: RouteName.loginScreen),
          SizedBox(height: 1.0.hp),
          Column(
            children: List.generate(
              4,
              (index) => const SmallNewsCard(),
            ),
          ),
          SizedBox(height: 3.0.hp),

          // Recent News
          const CustomHeadlineView(
              title: "Recent", routePath: RouteName.loginScreen),
          SizedBox(height: 1.0.hp),
          Column(
            children: [
              for (int index = 0; index < numberOfArticles; index++)
                if (index % 4 == 3 && index ~/ 4 < largeBannerAds.length)
                  BannerAdsCard(bannerAd: largeBannerAds[index ~/ 4])
                else
                  const SmallNewsCard(),
            ],
          ),

          SizedBox(height: 3.0.hp),
        ],
      ),
    );
  }
}
