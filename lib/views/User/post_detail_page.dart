import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:time4taqwa/controllers/stripe_controller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/custom_dialogboxes.dart';

class PostDetailPage extends StatefulWidget {
  final List<String>? donations;
  final String masjidname, amount, description, title;

  const PostDetailPage({
    super.key,
    required this.donations,
    required this.title,
    required this.masjidname,
    required this.amount,
    required this.description,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final amountController = TextEditingController();
  final stripeController = Get.put(StripeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.verticalSpace,
            Text(
              widget.masjidname,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.h.verticalSpace,
            GridView.builder(
                shrinkWrap: true,
                itemCount: widget.donations?.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 2,
                    mainAxisExtent: 100.h,
                    mainAxisSpacing: 10.w,
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return DottedBorder(
                    borderType: BorderType.RRect,
                    color: Colors.white,
                    radius: const Radius.circular(12),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        width: 200.w,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.donations?[index] ?? ""))),
                      ),
                    ),
                  );
                }),
            20.h.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.h.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Donation Title: ",
                        style: TextStyle(
                          color: AppColors.lightTextColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  10.h.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "Donation Amount: ",
                        style: TextStyle(
                          color: AppColors.lightTextColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.amount,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                  10.h.verticalSpace,
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
                          // "This is the description of the post. It can be a bit longer to test the text wrapping and alignment.",
                          widget.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(
        () => stripeController.isloading.value
            ? CustomWidgets.isloading
            : GestureDetector(
                onTap: () {
                  CustomDialogBox.paymentDialogBox(
                      context: context,
                      controller: amountController,
                      ontap: () {
                        setState(() {
                          Get.close(1);
                          log("amount====> ${amountController.text.runtimeType}");
                          stripeController.makePayment(
                            // context,
                            // amountController.text,
                            context: context,
                            description: widget.description,
                            mosqueName: widget.masjidname,
                            price: amountController.text,
                            title: widget.title,
                          );
                        });
                      });
                },
                child: Container(
                  width: Get.width,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: AppColors.lightTextColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      "Donate",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16.sp),
                    ),
                  ),
                ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
              ),
      ),
    );
  }
}
