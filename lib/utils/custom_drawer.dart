import 'package:time4taqwa/exportall.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.currentPage});
  final String currentPage;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RoutingController(),
        builder: (controller) {
          return Drawer(
            backgroundColor:
                Get.isDarkMode ? AppColors.primaryColor : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Container(
                //   height: 250.h,
                //   color: Theme.of(context).scaffoldBackgroundColor,
                //   child: Column(
                //     children: [
                //       20.h.verticalSpace,
                //       Container(
                //         height: 130.h,
                //         width: 130.w,
                //         decoration: const BoxDecoration(
                //             shape: BoxShape.circle,
                //             image: DecorationImage(
                //                 image: NetworkImage(
                //                     "https://gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200"))),
                //       ),
                //       20.h.verticalSpace,
                //       Text(
                //         lsk.username,
                //         overflow: TextOverflow.ellipsis,
                //         maxLines: 1,
                //         style: Theme.of(context).textTheme.displayMedium,
                //       )
                //     ],
                //   ),
                // ),
                Column(
                  children: [
                    ListTile(
                      title: Text("Home",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: controller.currentDrawer == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal)),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (currentPage == "homepage") return;
                        controller.setCurrentDrawer(0);
                        // Navigator.of(context).pushReplacement(MxaterialPageRoute(
                        //     builder: (BuildContext context) => HomePage()));
                        controller.setCurrentBottom(0);
                      },
                    ),
                    ListTile(
                      title: Text(
                        "About",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: controller.currentDrawer == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (currentPage == "splash") return;
                        controller.setCurrentDrawer(1);
                        controller.setCurrentBottom(1);
                      },
                    ),
                  ],
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: controller.currentDrawer == 1
                            ? FontWeight.bold
                            : FontWeight.normal),
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
