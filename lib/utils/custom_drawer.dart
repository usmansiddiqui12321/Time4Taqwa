import 'package:time4taqwa/exportall.dart';
import 'package:lottie/lottie.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.currentPage});
  final String currentPage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RoutingController(),
        builder: (controller) {
          return Drawer(
            backgroundColor: AppColors.primaryColor,
            child: Column(
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
                            if (currentPage == dkeys.homepage) return;
                            controller.setCurrentDrawer(0);
                            controller.setCurrentBottom(0);
                          },
                          isSelected: controller.currentDrawer == 0,
                          title: "Homepage"),
                      ItemsContainer(
                          onTap: () {
                            Navigator.of(context).pop();
                            if (currentPage == dkeys.searchMasjid) return;
                            controller.setCurrentDrawer(1);
                            controller.setCurrentBottom(1);
                          },
                          isSelected: controller.currentDrawer == 1,
                          title: "Search Mosques"),
                      ItemsContainer(
                          onTap: () {
                            Navigator.of(context).pop();
                            if (currentPage == dkeys.donations) return;
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
                          if (currentPage == dkeys.masjidsloc) return;
                          controller.setCurrentDrawer(3);
                          controller.setCurrentBottom(3);
                        },
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Get.offAll(const LoginPage());
                  },
                ),
              ],
            ),
          );
        });
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
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
