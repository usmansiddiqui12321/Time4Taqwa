import 'package:dotted_border/dotted_border.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/custom_textformfield.dart';

class EditPostDetails extends StatefulWidget {
  final String title, description, amount, masjidname;
  List<String>? donations;
  EditPostDetails({
    super.key,
    required this.donations,
    required this.title,
    required this.masjidname,
    required this.amount,
    required this.description,
  });

  @override
  State<EditPostDetails> createState() => _EditPostDetailsState();
}

class _EditPostDetailsState extends State<EditPostDetails> {
  List<String>? tempList = [];
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title;
    amountController.text = widget.amount;
    descriptionController.text = widget.description;
    // tempList?.add(widget.donations);
    // tempList = widget.donations;
    tempList?.addAll(widget.donations!);
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
          height: .9.sh,
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
                    shrinkWrap: true,
                    itemCount: tempList?.length,
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
                                        image: NetworkImage(
                                            tempList?[index] ?? ""))),
                              ),
                            ),
                          ),
                          Positioned(
                              top: -5.0,
                              right: -5.0,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    tempList?.removeAt(index);
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
                  TitlewithTextEditor(
                      title: "Title", controller: titleController),
                  10.h.verticalSpace,
                  TitlewithTextEditor(
                    title: "Amount",
                    controller: amountController,
                    textInputType: TextInputType.number,
                  ),
                  10.h.verticalSpace,
                  TitlewithTextEditor(
                      title: "Description", controller: descriptionController),
                  // 10.h.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 20.w),
              GestureDetector(
                onTap: () {},
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
  final String title;
  final TextInputType? textInputType;
  final TextEditingController controller;
  const TitlewithTextEditor(
      {super.key,
      required this.title,
      required this.controller,
      this.textInputType});

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
          maxLines: 3,
          minLines: 1,
          labelText: title,
          controller: controller,
          hint: "Enter $title Time here",
        ),
      ],
    );
  }
}
