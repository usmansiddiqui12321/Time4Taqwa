import 'package:time4taqwa/exportall.dart';
import 'dart:ui';

class AdminPostDetailPage extends StatefulWidget {
  // final String imageUrl;
  final List donations;
  final String masjidname, amount, description, title, id;
  final TabController tabController;
  const AdminPostDetailPage(
      {super.key,
      required this.donations,
      required this.masjidname,
      required this.amount,
      required this.description,
      required this.id,
      required this.title,
      required this.tabController});

  @override
  State<AdminPostDetailPage> createState() => _AdminPostDetailPageState();
}

class _AdminPostDetailPageState extends State<AdminPostDetailPage> {
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
              itemCount: widget.donations.length ?? 0,
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
                    _showCustomDialog(context, widget.donations[index] ?? "");
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
                            image: NetworkImage(widget.donations[index] ?? ""),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          
            10.h.verticalSpace,
              Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white, width: 2)
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
            ),],
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
                postId: widget.id,
                tabController: widget.tabController,
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
