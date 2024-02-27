import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time4taqwa/controllers/post_controller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/custom_textformfield.dart';

class EditPostDetails extends StatefulWidget {
  final String title, description, amount, masjidname, postId;
  List donations;
  final TabController tabController;
  @override
  EditPostDetails({
    super.key,
    required this.donations,
    required this.title,
    required this.masjidname,
    required this.postId,
    required this.amount,
    required this.description,
    required this.tabController,
  });

  @override
  State<EditPostDetails> createState() => _EditPostDetailsState();
}

class _EditPostDetailsState extends State<EditPostDetails> {
  final ImagePicker picker = ImagePicker();
  ImageProvider _getImageProvider(dynamic item) {
    if (item is String) {
      // If it's a String, assume it's a network image URL
      return NetworkImage(item);
    } else if (item is File) {
      // If it's a File, use FileImage
      return FileImage(item);
    } else {
      // Handle other cases if needed
      return const AssetImage('path/to/placeholder_image.jpg');
    }
  }

  void pickMultipleImages() async {
    try {
      // setState(() {
      //   isLoading = true;
      // });
      final result = await picker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        tempList.add(
          File(result.path.toString()),
        );
        setState(() {});
      }
      // setState(() {
      //   isLoading = false;
      // });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // isLoading = false;
    }
  }

  final postController = Get.put(PostController());
  List tempList = [];
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title;
    amountController.text = widget.amount;
    descriptionController.text = widget.description;
    tempList.addAll(widget.donations);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.h.verticalSpace,
                  Text(
                    "Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.h.verticalSpace,
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tempList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 2,
                        mainAxisExtent: 100.h,
                        mainAxisSpacing: 10.w,
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          DottedBorder(
                            borderType: BorderType.RRect,
                            color: Colors.white,
                            radius: const Radius.circular(12),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                clipBehavior: Clip.none,
                                width: 200.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: _getImageProvider(tempList[index]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          tempList.length == 1
                              ? const SizedBox.shrink()
                              : Positioned(
                                  top: -5.0,
                                  right: -5.0,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        tempList.removeAt(index);
                                        log("IMAGESSSS   ++++++ ======> $tempList");
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18.sp,
                                      ),
                                    ),
                                  )),
                        ],
                      );
                    },
                  ),
                  // 15.h.verticalSpace,
                  10.h.verticalSpace,
                  tempList.length == 5
                      ? const SizedBox.shrink()
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          color: Colors.white,
                          radius: const Radius.circular(12),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  pickMultipleImages();
                                  log("IMAGESSSS   ++++++ ======> $tempList");
                                });
                              },
                              child: Container(
                                width: Get.width,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.white,
                                    ),
                                    10.h.verticalSpace,
                                    const Text("Add Image"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  TitlewithTextEditor(
                    title: "Title",
                    controller: titleController,
                    maxLines: 1,
                  ),
                  10.h.verticalSpace,
                  TitlewithTextEditor(
                    title: "Amount",
                    controller: amountController,
                    maxLines: 1,
                    textInputType: TextInputType.number,
                  ),
                  10.h.verticalSpace,
                  TitlewithTextEditor(
                      title: "Description",
                      controller: descriptionController,
                      maxLines: 4),
                  // 10.h.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 20.w),
              GestureDetector(
                onTap: () {
                  // log(message);
                  log("IMAGESSSS   ++++++ ======> $tempList");

                  if (tempList.isEmpty) {
                    CustomWidgets.customsnackbar(
                        message: "Please Add Image", isError: true);
                  } else {
                    postController.editPost(
                        title: titleController.text,
                        description: descriptionController.text,
                        amount: amountController.text,
                        mosqueName: widget.masjidname,
                        postId: widget.postId,
                        images: tempList,
                        context: context,
                        tabController: widget.tabController);
                  }
                },
                child: Container(
                  width: Get.width,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: AppColors.lightTextColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 16.sp),
                    ),
                  ),
                ).paddingSymmetric(vertical: 20.h, horizontal: 20.w),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitlewithTextEditor extends StatelessWidget {
  final int? maxLines;
  final String title;
  final TextInputType? textInputType;
  final TextEditingController controller;
  const TitlewithTextEditor(
      {super.key,
      required this.title,
      required this.controller,
      this.textInputType,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        8.h.verticalSpace,
        CustomTextFormField(
          keyboardType: textInputType,
          maxLines: maxLines,
          minLines: 1,
          labelText: title,
          controller: controller,
          hint: "Enter $title Time here",
        ),
      ],
    );
  }
}
