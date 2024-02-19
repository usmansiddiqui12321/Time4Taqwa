import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/models/caretaker_login_model.dart';
import 'package:time4taqwa/views/admin/admin_homepage.dart';
import 'package:time4taqwa/views/admin/admin_login.dart';

class SegregationPage extends StatefulWidget {
  const SegregationPage({super.key});

  @override
  State<SegregationPage> createState() => _SegregationPageState();
}

class _SegregationPageState extends State<SegregationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            80.h.verticalSpace,
            Image(
              image: const AssetImage("assets/Quran.png"),
              height: 70.sp,
              width: 70.sp,
            ),
            40.h.verticalSpace,
            Text(
              lsk.appname,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColors.lightTextColor),
            ),
            40.h.verticalSpace,
            Segregationbutton(
              title: "User",
              onTap: () {
                Get.to(() => const LoginPage());
              },
            ),
            20.h.verticalSpace,
            Segregationbutton(
              title: "Masjid\nCareTaker",
              onTap: () {
                Get.to(() => const AdminLoginPage());
              },
            )
          ],
        ),
      ),
    );
  }
}

class Segregationbutton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const Segregationbutton({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: 150.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.deepPurple[700] as Color),
          color: AppColors.lightTextColor,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF672CBC),
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
