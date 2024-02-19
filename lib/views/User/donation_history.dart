import 'package:time4taqwa/controllers/donation_controller.dart';
import 'package:time4taqwa/exportall.dart';

class DonationHistory extends StatefulWidget {
  const DonationHistory({super.key});

  @override
  State<DonationHistory> createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory> {
  final historyController = Get.put(DonationController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    historyController.getdonationHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
      ),
      body: Obx(
        () => historyController.isloading.value
            ? Center(child: CustomWidgets.isloading)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyle(
                      color: AppColors.whitecolor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ).paddingOnly(left: 20.w, bottom: 10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: historyController.viewdonationhistorymodel.value
                            .data?.donations?.length ??
                        0,
                    itemBuilder: (context, index) {
                      var data = historyController.viewdonationhistorymodel
                          .value.data?.donations?[index];

                      var title = data?.title ?? "";
                      var mosqueName = data?.mosqueName ?? "";
                      var description = data?.description ?? "";
                      var amount = data?.amount.toString() ?? "";
                      return Container(
                        // height: 200.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: AppColors.containerColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mosqueName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Title: ",
                                  style: TextStyle(
                                    color: AppColors.lightTextColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Amount: ",
                                  style: TextStyle(
                                    color: AppColors.lightTextColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  amount,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description: ",
                                  style: TextStyle(
                                    color: AppColors.lightTextColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    description,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
                      ).paddingSymmetric(horizontal: 20.w, vertical: 10.h);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
