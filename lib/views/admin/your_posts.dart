import 'package:time4taqwa/controllers/donation_controller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/admin/admin_post_detail_page.dart';
// import 'package:time4taqwa/views/admin/admin_post_detail_page.dart';

class YourPosts extends StatefulWidget {
  final TabController tabController;

  const YourPosts({super.key, required this.tabController});

  @override
  State<YourPosts> createState() => _YourPostsState();
}

class _YourPostsState extends State<YourPosts> {
  final donationController = Get.put(DonationController());
  final authcontroller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    donationController.getDonationsbyEmail(
        email:
            authcontroller.caretakerloginmodel.value.data?.caretaker?.email ??
                "",
        loading: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.tabController.animateTo(1);
        },
        backgroundColor: AppColors.drawerColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Obx(
        () => donationController.isloading.value
            ? Center(child: CustomWidgets.isloading)
            : GridView.builder(
                shrinkWrap: true,
                itemCount: donationController
                    .getdonationmodel.value.data?.donations?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 2,
                    mainAxisExtent: 275.h,
                    mainAxisSpacing: 10.w,
                    crossAxisCount: 2),
                // physics: const BouncingScrollPhysics(),
                // shrinkWrap: true,
                // itemCount: 3,
                itemBuilder: (context, index) {
                  var data = donationController
                      .getdonationmodel.value.data?.donations?[index];
                  var masjidName = data?.mosqueName ?? "";
                  var amount = data?.amount.toString() ?? "";
                  var title = data?.title.toString() ?? "";
                  var description = data?.description ?? "";
                  var id = data?.id ?? "";
                  var email = data?.email ?? "";
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => AdminPostDetailPage(
                                  title: title,
                                  masjidname: masjidName,
                                  tabController: widget.tabController,
                                  id: id,
                                  donations: donationController
                                      .getdonationmodel
                                      .value
                                      .data
                                      ?.donations?[index]
                                      .images as List,
                                  amount: amount,
                                  description: description,
                                  // imageUrl: donationController.getdonationmodel.value
                                  //         .data?.donations?[index].images?[0] ??
                                  //     "",
                                ))!
                            .whenComplete(() {
                          donationController.getDonationsbyEmail(
                              email: email, loading: false);
                        });
                      },
                      child: Container(
                        // height: 250.h,
                        // width: Get.width,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(donationController
                                          .getdonationmodel
                                          .value
                                          .data
                                          ?.donations?[index]
                                          .images?[0] ??
                                      ""),
                                ),
                              ),
                            ),
                            5.h.verticalSpace,
                            SizedBox(
                              width: 130.w,
                              child: Text(
                                  maxLines: 1,
                                  title,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold)),
                            ).paddingSymmetric(horizontal: 10.w),
                            SizedBox(
                              width: 130.w,
                              child: Text(
                                maxLines: 1,
                                masjidName,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ).paddingSymmetric(horizontal: 10.w),

                            20.h.verticalSpace,
                            // const Text("Rs 2000left")
                            //     .paddingSymmetric(horizontal: 10.w)

                            const Text(
                              maxLines: 1,
                              "see details",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12),
                            ).paddingOnly(left: 10.w),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
