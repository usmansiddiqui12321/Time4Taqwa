import 'package:dotted_border/dotted_border.dart';
import 'package:time4taqwa/controllers/post_controller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/admin/edit_post_details.dart';
import 'package:time4taqwa/widgets/custom_dialogboxes.dart';

class AdminPostDetailPage extends StatefulWidget {
  // final String imageUrl;
  final List<String>? donations;
  final String masjidname, amount, description, title, id;

  const AdminPostDetailPage(
      {super.key,
      required this.donations,
      required this.masjidname,
      required this.amount,
      required this.description,
      required this.id,
      required this.title});

  @override
  State<AdminPostDetailPage> createState() => _AdminPostDetailPageState();
}

class _AdminPostDetailPageState extends State<AdminPostDetailPage> {
  final postcontroller = Get.put(PostController());
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
        actions: [
          GestureDetector(
            onTap: () {
              CustomDialogBox.deletePostDialogBox(
                  context: context,
                  ontap: () {
                    Get.close(1);
                    postcontroller.deletePost(id: widget.id);
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red)),
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ).paddingOnly(right: 15.w),
          )
        ],
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
                // itemCount: 3,
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
            10.h.verticalSpace,
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
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => EditPostDetails(
                amount: widget.amount,
                description: widget.description,
                masjidname: widget.masjidname,
                title: widget.title,
                donations: widget.donations,
              ));
        },
        child: Container(
          width: Get.width,
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.lightTextColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Center(
            child: Text(
              "Edit Post",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 16.sp),
            ),
          ),
        ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

          // GestureDetector(
          //   onTap: () {
          //     Get.to(EditPostDetails(
          //       amount: '2500',
          //       description: "dsadsadas",
          //       imageUrls: widget.imageUrl,
          //       title: "dsadsadsa",
          //     ));
          //   },
          //   child: Container(
          //     padding: const EdgeInsets.all(5),
          //     decoration: const BoxDecoration(
          //         color: AppColors.lightTextColor, shape: BoxShape.circle),
          //     // width: 30.w,
          //     // height: 30.h,
          //     child: const Icon(
          //       Icons.edit,
          //       color: Colors.white,
          //     ),
          //   ).paddingOnly(right: 15.w),
          // )