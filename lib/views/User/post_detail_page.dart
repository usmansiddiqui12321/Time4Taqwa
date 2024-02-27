import 'dart:developer';
import 'dart:ui';

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
  void _showCustomDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.transparent,
              child: Container(
                width: 300.w,
                height: 250.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    _showCustomDialog(context, widget.donations?[index] ?? "");
                  },
                  onLongPressEnd: (details) {
                    Navigator.of(context)
                        .pop(); // Close the dialog when the long press is released
                  },
                  child: DottedBorder(
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
                            image: NetworkImage(widget.donations?[index] ?? ""),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            20.h.verticalSpace,
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 2)
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.3),
                  //     spreadRadius: 2,
                  //     blurRadius: 5,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // Donation Title
                  Text(
                    "Title",
                    style: TextStyle(
                      color: AppColors.lightTextColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Donation Amount
                  Text(
                    "Amount",
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
                  ),
                  SizedBox(height: 10.h),

                  // Description
                  Text(
                    "Description",
                    style: TextStyle(
                      color: AppColors.lightTextColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
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
