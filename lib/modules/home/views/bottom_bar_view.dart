import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:post_caption/modules/feed/views/feed_screen.dart';
import 'package:post_caption/modules/search/views/search_screen.dart';
import 'package:post_caption/services/ads/ad_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../generated/assets.dart';
import '../../setting/views/settings_view.dart';
import '../controllers/bottom_bar_controller.dart';
import 'home_view.dart';

class BottomBarView extends StatefulWidget {
  BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  final BottomBarController c = Get.put(BottomBarController());

  final List<Widget> screens = [
    HomeView(),
    SearchScreen(),
    // FindCaptionScreen(),
    FeedView(),
    SettingsView(),
  ];

  final iconList = <IconData>[Icons.home_rounded, Icons.settings_rounded];

  @override
  void initState() {
    AdService().loadBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        body: screens[c.currentIndex.value],
        bottomNavigationBar: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AdService().bannerAd == null
                ? const SizedBox()
                : SizedBox(
              height: AdService().bannerAd!.size.height.toDouble(),
              width: AdService().bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: AdService().bannerAd!),
            ),
            SnakeNavigationBar.color(
              behaviour: SnakeBarBehaviour.floating,
              backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              elevation: 1,
              snakeShape: SnakeShape.indicator,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(16),
              // ),
              snakeViewColor: AppColors.neonPink,
              shadowColor: Colors.black,
              // padding: EdgeInsets.symmetric(horizontal: 14),
              currentIndex: c.currentIndex.value,
              onTap: (index) => c.currentIndex.value = index,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.imagesFiRrHome,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'home',
                  activeIcon: SvgPicture.asset(
                    Assets.imagesFiSrHome,
                    colorFilter: const ColorFilter.mode(
                      AppColors.neonPink,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded,color: Colors.grey,size: 32,),
                  label: 'create',
                  activeIcon: Icon(Icons.search_rounded,color: AppColors.neonPink,size: 32,),
                ),
                // BottomNavigationBarItem(
                //   icon: SvgPicture.asset(
                //     Assets.imagesFiRrAdd,
                //     colorFilter: const ColorFilter.mode(
                //       Colors.grey,
                //       BlendMode.srcIn,
                //     ),
                //   ),
                //   label: 'create',
                //   activeIcon: SvgPicture.asset(
                //     Assets.imagesFiSrAdd,
                //     colorFilter: const ColorFilter.mode(
                //       AppColors.neonPink,
                //       BlendMode.srcIn,
                //     ),
                //   ),
                // ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.imagesFiRrBrowser,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'feed',
                  activeIcon: SvgPicture.asset(
                    Assets.imagesFiSrBrowser,
                    colorFilter: const ColorFilter.mode(
                      AppColors.neonPink,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.imagesFiRrSettings,
                    colorFilter: const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'setting',
                  activeIcon: SvgPicture.asset(
                    Assets.imagesFiSrSettings,
                    colorFilter: const ColorFilter.mode(
                      AppColors.neonPink,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

/*Scaffold(
extendBody: true, // IMPORTANT for floating nav bar
body: Stack(
children: [
// ----- MAIN SCREEN -----
Obx(() =>  screens[c.currentIndex.value],),

// ----- BANNER AD AT REAL BOTTOM -----
Positioned(
bottom: 110,
left: 0,
right: 0,
child: AdService().bannerAd == null
? const SizedBox()
    : SizedBox(
height: AdService().bannerAd!.size.height.toDouble(),
width: AdService().bannerAd!.size.width.toDouble(),
child: AdWidget(ad: AdService().bannerAd!),)

)
],
),

// ----- FLOATING BUTTON -----
floatingActionButton: FloatingActionButton(
onPressed: () {},
child: const Icon(Icons.add),
),

floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

// ----- BOTTOM NAV BAR (ONLY NAV BAR) -----
bottomNavigationBar: AnimatedBottomNavigationBar(
icons: iconList,
activeIndex: c.currentIndex.value == 1
? 3
    : (c.currentIndex.value == 0 ? 0 : 1),
gapLocation: GapLocation.center,
notchSmoothness: NotchSmoothness.defaultEdge,
backgroundColor: Colors.black87,
activeColor: Colors.orange,
inactiveColor: Colors.white,
splashColor: Colors.orange,
elevation: 20,
onTap: (index) {
if (index == 0) {
c.changeIndex(0);
} else {
c.changeIndex(2);
}
},
),
)*/

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../services/ads/ad_service.dart';
import '../../create/views/create_view.dart';
import '../controllers/bottom_bar_controller.dart';
import 'home_view.dart';
import '../../setting/views/settings_view.dart';


class BottomBarView extends StatelessWidget {
  BottomBarView({super.key});

  final BottomBarController c = Get.put(BottomBarController());

  final List<Widget> screens = [
    HomeView(),
    CreateView(),
    SettingsView(),
  ];

  final iconList = <IconData>[
    Icons.home_rounded,
    Icons.settings_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        body: screens[c.currentIndex.value],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          elevation: 6,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 28, color: Colors.white),
          onPressed: () => c.changeIndex(1),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: Stack(
          children: [
            AnimatedBottomNavigationBar(
              icons: iconList,
              // height: 120,
              activeIndex: c.currentIndex.value == 1
                  ? 3
                  : (c.currentIndex.value == 0 ? 0 : 1),
              iconSize: 30.0,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              backgroundColor: Colors.black87,
              activeColor: Colors.orange,
              inactiveColor: Colors.white,
              splashColor: Colors.orange,
              elevation: 20,
              onTap: (index) {
                if (index == 0) {
                  c.changeIndex(0);
                } else {
                  c.changeIndex(2);
                }
              },
            ),
            // Positioned(
            //     bottom: 0,
            //     left: 0,
            //     right: 0,
            //     child: AdService().bannerAd == null
            //     ? const SizedBox()
            //     : SizedBox(
            //   height: AdService().bannerAd!.size.height.toDouble(),
            //   width: AdService().bannerAd!.size.width.toDouble(),
            //   child: AdWidget(ad: AdService().bannerAd!),)
            // )
          ],
        ),
      );
    });
  }
}*/

/*Scaffold(
extendBody: true, // IMPORTANT for floating nav bar
body: Stack(
children: [
// ----- MAIN SCREEN -----
Obx(() =>  screens[c.currentIndex.value],),

// ----- BANNER AD AT REAL BOTTOM -----
Positioned(
bottom: 110,
left: 0,
right: 0,
child: AdService().bannerAd == null
? const SizedBox()
    : SizedBox(
height: AdService().bannerAd!.size.height.toDouble(),
width: AdService().bannerAd!.size.width.toDouble(),
child: AdWidget(ad: AdService().bannerAd!),)

)
],
),

// ----- FLOATING BUTTON -----
floatingActionButton: FloatingActionButton(
onPressed: () {},
child: const Icon(Icons.add),
),

floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

// ----- BOTTOM NAV BAR (ONLY NAV BAR) -----
bottomNavigationBar: AnimatedBottomNavigationBar(
icons: iconList,
activeIndex: c.currentIndex.value == 1
? 3
    : (c.currentIndex.value == 0 ? 0 : 1),
gapLocation: GapLocation.center,
notchSmoothness: NotchSmoothness.defaultEdge,
backgroundColor: Colors.black87,
activeColor: Colors.orange,
inactiveColor: Colors.white,
splashColor: Colors.orange,
elevation: 20,
onTap: (index) {
if (index == 0) {
c.changeIndex(0);
} else {
c.changeIndex(2);
}
},
),
)*/
