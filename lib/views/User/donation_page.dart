import 'package:time4taqwa/exportall.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final themecontroller = ThemeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        // backgroundColor: ,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage("assets/drawer.png")),
          ),
        ),
        // actions: [
        //   GetBuilder(
        //       init: themecontroller,
        //       builder: (controller) {
        //         return Padding(
        //           padding: EdgeInsets.only(right: 24.w),
        //           child: Switch(
        //             value: controller.isDarkMode,
        //             onChanged: (val) {
        //               controller.toggleTheme();
        //               if (kDebugMode) {
        //                 print(controller.isDarkMode.toString());
        //               }
        //             },
        //           ),
        //         );
        //       }),
        // ],
        title: Text(
          lsk.appname,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: const CustomDrawer(currentPage: dkeys.donations),
    );
  }
}
