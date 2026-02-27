import 'package:get/get.dart';
import 'package:post_caption/modules/messages/bindings/message_list_binding.dart';
import 'package:post_caption/modules/messages/views/message_list_view.dart';
import '../modules/feed/bindings/feed_binding.dart';
import '../modules/feed/views/feed_screen.dart';
import '../modules/findCaption/binding/find_caption_binding.dart';
import '../modules/findCaption/views/find_caption_screen.dart';
import '../modules/findCaption/views/get_captions.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/home/views/bottom_bar_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/splash_screen.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_screen.dart';
import '../modules/setting/views/like_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.bottomBar,
      page: () => BottomBarView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.messagesList,
      page: () => MessageListView(),
      binding: MessageListBinding(),
    ),
    GetPage(
      name: AppRoutes.likedMessagesView,
      page: () => LikedMessagesView(),
    ),
    GetPage(
      name: AppRoutes.feed,
      page: () => FeedView(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: AppRoutes.findCaptionScreen,
      page: () =>  FindCaptionScreen(),
      binding: FindCaptionBinding(),
    ),
    GetPage(
      name: AppRoutes.getCaptionsView,
      page: () =>  GetCaptionsView(),
      binding: FindCaptionBinding(),
    ),
    GetPage(
      name: AppRoutes.searchScreen,
      page: () =>  SearchScreen(),
      binding: SearchBinding(),
    ),
  ];
}
