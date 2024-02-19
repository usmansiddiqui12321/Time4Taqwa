import '../exportall.dart';

class CustomTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.primaryColor,
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme().copyWith(
        displayLarge: TextStyle(
            fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.white),
        displayMedium: TextStyle(
            fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
        displaySmall: TextStyle(
            fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      // foregroundColor: Colors.white
    ),
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme().copyWith(
        displayLarge: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor),
        displayMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor),
        displaySmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor),
      ),
    ),
    primaryColor: Colors.white,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      // backgroundColor: AppColors.primaryColor.withOpacity(.50),
      // foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,

      titleTextStyle: GoogleFonts.poppins(
        color: const Color(0xFF672CBC),
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
      ),
      // color: AppColors.primaryColor.withOpacity(.50),
    ),
  );
}
