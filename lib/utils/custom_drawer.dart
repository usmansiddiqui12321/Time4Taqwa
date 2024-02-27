import 'package:time4taqwa/exportall.dart';
import 'package:lottie/lottie.dart';
import 'package:time4taqwa/views/User/donation_history.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.currentPage});
  final String currentPage;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        key: scaffoldKey,
        backgroundColor: AppColors.primaryColor,
        child: GetBuilder(
            init: RoutingController(),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 50.h, horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Lottie.asset('assets/animation.json',
                                height: 150, width: 150)),
                        ItemsContainer(
                            onTap: () {
                              Navigator.of(context).pop();
                              if (widget.currentPage == dkeys.homepage) return;
                              controller.setCurrentDrawer(0);
                              controller.setCurrentBottom(0);
                            },
                            isSelected: controller.currentDrawer == 0,
                            title: "Homepage"),
                        ItemsContainer(
                            onTap: () {
                              Navigator.of(context).pop();
                              if (widget.currentPage == dkeys.searchMasjid)
                                return;
                              controller.setCurrentDrawer(1);
                              controller.setCurrentBottom(1);
                            },
                            isSelected: controller.currentDrawer == 1,
                            title: "Search Mosques"),
                        ItemsContainer(
                            onTap: () {
                              Navigator.of(context).pop();
                              if (widget.currentPage == dkeys.donations) return;
                              controller.setCurrentDrawer(2);
                              controller.setCurrentBottom(2);
                            },
                            isSelected: controller.currentDrawer == 2,
                            title: "Donations"),
                        ItemsContainer(
                          isSelected: controller.currentDrawer == 3,
                          title: "Mosques Locations",
                          onTap: () {
                            Navigator.of(context).pop();
                            if (widget.currentPage == dkeys.masjidsloc) return;
                            controller.setCurrentDrawer(3);
                            controller.setCurrentBottom(3);
                          },
                        ),
                        ItemsContainer(
                          isSelected: controller.currentDrawer == 4,
                          title: "Donations History",
                          onTap: () {
                            Get.close(1);
                            Get.to(() => const DonationHistory());
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.offAll(const LoginPage());
                    },
                  ),
                ],
              );
            }));
  }
}

class ItemsContainer extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final bool isSelected;
  const ItemsContainer(
      {super.key,
      required this.onTap,
      required this.isSelected,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.only(left: 10.h, top: 8.h),
          width: Get.width,
          height: 40.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.drawerColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
