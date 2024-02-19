import 'package:time4taqwa/controllers/donation_controller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/User/post_detail_page.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final donationController = Get.put(DonationController());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    donationController.getAllDonations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
              // Scaffold.of(context).openDrawer();
            },
            child: Image(
                height: 24.h,
                width: 24.w,
                image: const AssetImage("assets/drawer.png")),
          ),
        ),
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
      body: Obx(
        () => donationController.isloading.value
            ? Center(child: CustomWidgets.isloading)
            : GridView.builder(
                shrinkWrap: true,
                itemCount: donationController
                    .getalldonationmodel.value.data?.donations?.length,
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
                      .getalldonationmodel.value.data?.donations?[index];
                  var masjidName = data?.mosqueName ?? "";
                  var amount = data?.amount.toString() ?? "";
                  var title = data?.title.toString() ?? "";
                  var description = data?.description ?? "";
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(PostDetailPage(
                          title: title,
                          masjidname: masjidName,
                          donations: donationController.getalldonationmodel
                              .value.data?.donations?[index].images,
                          amount: amount,
                          description: description,
                        ));
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
                                          .getalldonationmodel
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
