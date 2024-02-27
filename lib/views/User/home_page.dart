import 'package:time4taqwa/controllers/home_page_controller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/User/islamic_calender.dart';
import 'package:time4taqwa/views/User/qaza_namaz_screen.dart';
import 'package:time4taqwa/views/User/tasbeeh_counter.dart';
import 'package:time4taqwa/views/User/zakat_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navcontroller = Get.put(RoutingController());

  final authController = Get.put(AuthController());
  final homecontroller = Get.put(HomePageController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        child: SingleChildScrollView(
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
                authController.userloginmodel.value.data?.user?.username ?? "",
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
                "Features",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              10.h.verticalSpace,
              //! FEATURES
              Container(
                  height: 200.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          width: 2, color: AppColors.lightTextColor)),
                  child: ListView(
                    children: [
                      5.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          20.w.horizontalSpace,
                          FeaturesIcon(
                            title: "Calender",
                            ontap: () {
                              Get.to(() => const HijriDatePickerScreen());
                            },
                            display: const Icon(Icons.calendar_month),
                          ),
                          20.w.horizontalSpace,
                          FeaturesIcon(
                            title: "Zakat\nCounter",
                            ontap: () {
                              Get.to(() => const ZakatCalculatorScreen());
                            },
                            display: const ImageIcon(
                              AssetImage("assets/zakat.png"),
                              color: Colors.white,
                            ),
                          ),
                          20.w.horizontalSpace,
                          FeaturesIcon(
                            title: "Qaza\nNamaz",
                            ontap: () {
                              Get.to(() => QazaNamazCounterScreen());
                            },
                            display: const ImageIcon(
                              AssetImage("assets/praying.png"),
                              color: Colors.white,
                            ),
                          ),
                          20.w.horizontalSpace,
                        ],
                      ),
                      5.h.verticalSpace,
                      Row(
                        children: [
                          20.w.horizontalSpace,
                          FeaturesIcon(
                            title: "Tasbeeh",
                            ontap: () {
                              Get.to(() => const TasbeehScreen());
                            },
                            display: const ImageIcon(
                              AssetImage("assets/beads.png"),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ).paddingOnly(left: 10.w)
                    ],
                  )),
              10.h.verticalSpace,
              Text(
                "Following",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              20.h.verticalSpace,
              GetBuilder(
                  init: navcontroller,
                  builder: (controller) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.r),
                            child: GestureDetector(
                              onTap: () {
                                controller.setCurrentBottom(1);
                                controller.setCurrentDrawer(1);
                              },
                              child: Container(
                                height: 110.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.lightTextColor),
                                    color: const Color(0xFF121931),
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    10.h.verticalSpace,
                                    const Icon(
                                        Icons.access_time_filled_outlined),
                                    20.h.verticalSpace,
                                    const Text(
                                      textAlign: TextAlign.center,
                                      "Namaz\nTime",
                                      style: TextStyle(
                                          color: AppColors.lightTextColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.r),
                            child: FollowingWidget(
                                ontap: () {
                                  controller.setCurrentBottom(2);
                                  controller.setCurrentDrawer(2);
                                },
                                title: "Donations",
                                image: "assets/donation.png"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.r),
                            child: GestureDetector(
                              onTap: () {
                                controller.setCurrentBottom(3);
                                controller.setCurrentDrawer(3);
                              },
                              child: Container(
                                height: 110.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.lightTextColor),
                                    color: const Color(0xFF121931),
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // 5.h.verticalSpace,
                                    const Icon(Icons.location_on),
                                    20.h.verticalSpace,
                                    const Text(
                                      textAlign: TextAlign.center,
                                      "Locate\nMosque",
                                      style: TextStyle(
                                          color: AppColors.lightTextColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              20.h.verticalSpace,
            ],
          ),
        ),
      )),
    );
  }
}

class FeaturesIcon extends StatelessWidget {
  final Widget display;
  final String title;
  final void Function()? ontap;

  const FeaturesIcon({
    Key? key,
    required this.display,
    this.ontap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 102.h,
      child: Column(
        children: [
          GestureDetector(
            onTap: ontap,
            child: Container(
              height: 60.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 30.w, // Adjust the width as needed
                  height: 30.h, // Adjust the height as needed
                  child: display,
                ),
              ),
            ),
          ),
          5.h.verticalSpace,
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}

class FollowingWidget extends StatelessWidget {
  final String image, title;
  final void Function()? ontap;

  const FollowingWidget({
    super.key,
    required this.image,
    required this.title,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 110.h,
        width: 100.w,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightTextColor),
            color: const Color(0xFF121931),
            borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 10.h.verticalSpace,
            ImageIcon(
              AssetImage(image),
              size: 30,
            ),
            20.h.verticalSpace,
            Text(
              title,
              style: const TextStyle(
                  color: AppColors.lightTextColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
