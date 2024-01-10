import 'package:time4taqwa/exportall.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            86.h.verticalSpace,
            Text(
              lsk.appname,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            16.h.verticalSpace,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Empowering Prayer, Enabling Generosity – ${lsk.appname}, Your Spiritual Companion',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: AppColors.lightTextColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            49.h.verticalSpace,
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 380.h,
                  width: 314.w,
                  child: const Image(
                    image: AssetImage("assets/ssimage.png"),
                  ),
                ),
                Positioned(
                  bottom: -19.h,
                  left: 75.h,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const SegregationPage());
                    },
                    child: Container(
                      width: 185.w,
                      height: 60.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF9B091),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF091945),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
