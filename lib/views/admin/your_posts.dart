import 'package:time4taqwa/exportall.dart';

class YourPosts extends StatefulWidget {
  final TabController tabController;
  const YourPosts({super.key, required this.tabController});

  @override
  State<YourPosts> createState() => _YourPostsState();
}

class _YourPostsState extends State<YourPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.tabController.animateTo(1);
        },
        backgroundColor: AppColors.drawerColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Container(
              height: 250.h,
              width: Get.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 34, 44, 79),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2.r,
                    blurRadius: 5.r,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r)),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/cooler.jpeg'))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: Text(
                            maxLines: 1,
                            "Cooler",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16.sp)),
                      ),
                      const Text(
                        maxLines: 1,
                        "see details",
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 12),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10.w, vertical: 10.h),
                  20.h.verticalSpace,
                  const Text("Rs 2000left").paddingSymmetric(horizontal: 10.w)
                ],
              ),
            ),
          );
        },
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
