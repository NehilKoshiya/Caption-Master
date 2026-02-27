import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_caption/services/ads/ad_service.dart';
import 'core/constants/app_colors.dart';
import 'modules/setting/controllers/setting_controller.dart';
import 'routes/app_pages.dart';
import 'core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await AppConfig.init();
  await AdService().initialize();
  AdService.loadNativeAd();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Caption Master',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: settingController.themeMode.value,
    );
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightPrimaryBg,

  primaryColor: AppColors.neonPink,
  hintColor: AppColors.hotPink,

  colorScheme: const ColorScheme.light(
    background: AppColors.lightPrimaryBg,
    surface: AppColors.lightPinkTint,
    primary: AppColors.neonPink,
    secondary: AppColors.electricPurple,
  ),

  textTheme: TextTheme(
    bodyLarge: GoogleFonts.poppins(color: AppColors.lightTextPrimary),
    bodyMedium: GoogleFonts.poppins(color: AppColors.lightTextSecondary),
    titleLarge: GoogleFonts.poppins(color: AppColors.lightTextPrimary),
    titleMedium: GoogleFonts.poppins(color: AppColors.lightTextSecondary),
  ),

  primarySwatch: Colors.blue,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
  ),

  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      color: AppColors.lightTextSecondary,
      fontSize: 16,
    ),
    subtitleTextStyle: TextStyle(
      color: AppColors.lightTextSecondary,
      fontSize: 14,
    ),
  ),

  dividerTheme: DividerThemeData(
    color: AppColors.lightTextSecondary.withValues(alpha: 0.2),
    thickness: 1,
    space: 32,
  ),

  // textTheme: TextTheme(
  //   displayLarge: GoogleFonts.poppins(),
  //   displayMedium: GoogleFonts.poppins(),
  //   displaySmall: GoogleFonts.poppins(),
  //   headlineLarge: GoogleFonts.poppins(),
  //   headlineMedium: GoogleFonts.poppins(),
  //   headlineSmall: GoogleFonts.poppins(),
  //   titleLarge: GoogleFonts.poppins(),
  //   titleMedium: GoogleFonts.poppins(),
  //   titleSmall: GoogleFonts.poppins(),
  //   bodyLarge: GoogleFonts.poppins(),
  //   bodyMedium: GoogleFonts.poppins(),
  //   bodySmall: GoogleFonts.poppins(),
  //   labelLarge: GoogleFonts.poppins(),
  //   labelMedium: GoogleFonts.poppins(),
  //   labelSmall: GoogleFonts.poppins(),
  // ),
  cardColor: Color(0xffF7F7F8),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkPrimaryBg,

  primaryColor: AppColors.neonPink,
  hintColor: AppColors.hotPink,

  colorScheme: const ColorScheme.dark(
    background: AppColors.darkPrimaryBg,
    surface: AppColors.darkSoftBg,
    primary: AppColors.neonPink,
    secondary: AppColors.electricPurple,
  ),

  textTheme: TextTheme(
    bodyLarge: GoogleFonts.poppins(color: AppColors.darkTextPrimary),
    bodyMedium: GoogleFonts.poppins(color: AppColors.darkTextSecondary),
    titleLarge: GoogleFonts.poppins(color: AppColors.darkTextPrimary),
    titleMedium: GoogleFonts.poppins(color: AppColors.darkTextSecondary),
  ),

  primarySwatch: Colors.indigo,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.black,
    backgroundColor: Colors.black,
  ),

  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      color: AppColors.darkTextSecondary,
      fontSize: 16,
    ),
    subtitleTextStyle: TextStyle(
      color: AppColors.darkTextSecondary,
      fontSize: 14,
    ),
  ),

  dividerTheme: DividerThemeData(
    color: AppColors.darkTextSecondary.withValues(alpha: 0.3),
    thickness: 1,
    space: 32,
  ),

  // textTheme: TextTheme(
  //   displayLarge: GoogleFonts.poppins(),
  //   displayMedium: GoogleFonts.poppins(),
  //   displaySmall: GoogleFonts.poppins(),
  //   headlineLarge: GoogleFonts.poppins(),
  //   headlineMedium: GoogleFonts.poppins(),
  //   headlineSmall: GoogleFonts.poppins(),
  //   titleLarge: GoogleFonts.poppins(),
  //   titleMedium: GoogleFonts.poppins(),
  //   titleSmall: GoogleFonts.poppins(),
  //   bodyLarge: GoogleFonts.poppins(),
  //   bodyMedium: GoogleFonts.poppins(),
  //   bodySmall: GoogleFonts.poppins(),
  //   labelLarge: GoogleFonts.poppins(),
  //   labelMedium: GoogleFonts.poppins(),
  //   labelSmall: GoogleFonts.poppins(),
  // ),
  cardColor: Color(0xff232627),
);
