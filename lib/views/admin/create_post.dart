import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:time4taqwa/controllers/post_controller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time4taqwa/widgets/custom_textformfield.dart';

class CreatePost extends StatefulWidget {
  final TabController tabController;

  const CreatePost({super.key, required this.tabController});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final postController = Get.put(PostController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final ImagePicker picker = ImagePicker();
  bool isLoading = false;
  List<File?> filestoDisplay = [];

  void pickMultipleImages() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await picker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        filestoDisplay.add(
          File(result.path.toString()),
        );
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Images",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                20.h.verticalSpace,
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: filestoDisplay.length,
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
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          FileImage(filestoDisplay[index]!))),
                            ),
                          ),
                        ),
                        Positioned(
                            top: -5.0,
                            right: -5.0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  filestoDisplay.removeAt(index);
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
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
                10.h.verticalSpace,
                filestoDisplay.length == 5
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
                20.h.verticalSpace,
                Text(
                  "Details",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                20.h.verticalSpace,
                CustomTextFormField(
                  maxLines: 1,
                  controller: titleController,
                  hint: "Enter Title here",
                  labelText: "Title",
                ),
                15.h.verticalSpace,
                CustomTextFormField(
                  minLines: 3,
                  maxLines: 5,
                  controller: descriptionController,
                  hint: "Enter Description here",
                  labelText: "Description",
                ),
                15.h.verticalSpace,
                CustomTextFormField(
                  hint: "Enter Price Needed",
                  labelText: "Price",
                  keyboardType: TextInputType.number,
                  controller: pricecontroller,
                  maxLines: 1,
                  minLines: 1,
                ),
                postController.isloading.value
                    ? Center(child: CustomWidgets.isloading)
                    : GestureDetector(
                        onTap: () {
                          if (filestoDisplay.isEmpty) {
                            CustomWidgets.customsnackbar(
                              message: "Please Select Image",
                              isError: true,
                            );
                          } else if (titleController.text.isEmpty) {
                            CustomWidgets.customsnackbar(
                                message: "Title is not Allowed to be Empty",
                                isError: true);
                          } else if (descriptionController.text.isEmpty) {
                            CustomWidgets.customsnackbar(
                                message:
                                    "Description is not Allowed to be Empty",
                                isError: true);
                            // ignore: unrelated_type_equality_checks
                          } else if (pricecontroller.text.isEmpty) {
                            CustomWidgets.customsnackbar(
                                message: "Price is not Allowed to be Empty",
                                isError: true);
                          } else if (double.parse(pricecontroller.text) <= 0) {
                            CustomWidgets.customsnackbar(
                                message: "Price should be greater than 0",
                                isError: true);
                          } else {
                            postController.createPost(
                                tabController: widget.tabController,
                                title: titleController.text,
                                description: descriptionController.text,
                                amount: pricecontroller.text,
                                mosqueName: "Masjid AlNoor",
                                images: filestoDisplay,
                                context: context);
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
                              "Add Post",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp),
                            ),
                          ),
                        ).paddingSymmetric(vertical: 20.h),
                      ),
                20.h.verticalSpace
              ],
            ),
          ),
        ),
      ),
    );
  }
}
