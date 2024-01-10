import 'package:time4taqwa/exportall.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var  scaffoldKey = GlobalKey<ScaffoldState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final themecontroller = ThemeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      key: scaffoldKey,
      appBar: AppBar(
        // backgroundColor: AppColors.primaryColor,
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
        //               Get.changeThemeMode(controller.isDarkMode
        //                   ? ThemeMode.dark
        //                   : ThemeMode.light);
        //             },
        //           ),
        //         );
        //       }),
        // ],
        title: const Text(
          lsk.appname,
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const CustomDrawer(currentPage: "homepage"),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.h.verticalSpace,
            Text(
              'Asslamualaikum',
              style: TextStyle(
                color: const Color(0xFF8789A3),
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
            
              ),
            ),
            4.h.verticalSpace,
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              lsk.username,
              style: Theme.of(context).textTheme.displayLarge,
            )
          ],
        ),
      )),
    );
  }
}
