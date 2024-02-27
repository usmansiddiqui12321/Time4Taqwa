import 'dart:developer';
import 'dart:io';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/models/create_donation_model.dart';
import 'package:time4taqwa/services/post_service.dart';

class PostController extends GetxController {
  RxBool isloading = false.obs;
  // final controller
  Rx<CreatePostModel> createpostmodel = CreatePostModel().obs;
  final authController = Get.put(AuthController());
  Future<void> createPost(
      {required String title,
      required String description,
      required String amount,
      required String mosqueName,
      // required String email,
      required List<File?> images,
      required BuildContext context,
      required TabController tabController}) async {
    try {
      isloading(true);
      var result = await PostService().createPost(
          title: title,
          amount: amount,
          images: images,
          description: description,
          mosqueName: mosqueName,
          email:
              authController.caretakerloginmodel.value.data?.caretaker?.email ??
                  "");
      createpostmodel.value = result;
      tabController.animateTo(0);
      CustomWidgets.customsnackbar(
          message: "Donation Post Created Successfully", isError: false);
    } catch (e) {
      CustomWidgets.customsnackbar(message: e.toString(), isError: true);
      log("e ====> $e");
    } finally {
      isloading(false);
    }
  }

  Future<void> editPost(
      {required String title,
      required String description,
      required String amount,
      required String mosqueName,
      required String postId,
      // required String email,
      required List images,
      required BuildContext context,
      required TabController tabController}) async {
    try {
      isloading(true);
      var result = await PostService().editPost(
          title: title,
          postId: postId,
          amount: amount,
          images: images,
          description: description,
          mosqueName: mosqueName,
          email:
              authController.caretakerloginmodel.value.data?.caretaker?.email ??
                  "");
// BACK TWO TIMEs
      Get.close(2);
      CustomWidgets.customsnackbar(
          message: "Donation Post Edited Successfully", isError: false);
    } catch (e) {
      CustomWidgets.customsnackbar(message: e.toString(), isError: true);
      log("e ====> $e");
    } finally {
      isloading(false);
    }
  }

  Future<void> deletePost({required id}) async {
    try {
      var result = await PostService().deletePostservice(id: id);
      log(result.toString());
      // CustomDialogBox.deletePostDialogBox(context);
      Get.close(1);
    } catch (e) {
      CustomWidgets.customsnackbar(
          message: "Something went wrong", isError: true);
    }
  }
}
