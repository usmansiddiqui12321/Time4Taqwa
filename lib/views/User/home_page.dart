import 'package:time4taqwa/controllers/home_page_controller.dart';
import 'package:time4taqwa/exportall.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homecontroller = Get.put(HomePageController());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final themecontroller = ThemeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
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
        title: const Text(
          lsk.appname,
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const CustomDrawer(currentPage: dkeys.homepage),
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
            ),
            20.h.verticalSpace,
            Stack(
              children: [
                Container(
                  height: 131.h,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.71, -0.71),
                      end: Alignment(-0.71, 0.71),
                      colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu_book_outlined,
                          color: Colors.white,
                        ),
                        5.w.horizontalSpace,
                        const Text(
                          "Hadith Of The Day",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    )),
                Positioned(
                    top: 10.h,
                    right: 15.w,
                    child: Image(
                      image: const AssetImage("assets/Quran.png"),
                      height: 100.h,
                      width: 100.w,
                    )),
                GetBuilder(
                    init: homecontroller,
                    builder: (controller) {
                      return Positioned(
                          top: 40.h,
                          left: 10.w,
                          child: SizedBox(
                              width: 210.w,
                              height: 100.h,
                              child: Text(controller.changeHadith())));
                    }),
              ],
            ),
            30.h.verticalSpace,
            Text(
              "Following",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            20.h.verticalSpace,
            GridView.builder(
              itemCount: 3,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.r),
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lightTextColor),
                        color: const Color(0xFF121931),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        10.h.verticalSpace,
                        const ImageIcon(
                          AssetImage("assets/mosque_marker.png"),
                          size: 30,
                        ),
                        20.h.verticalSpace,
                        const Text(
                          "Donations",
                          style: TextStyle(
                              color: AppColors.lightTextColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
