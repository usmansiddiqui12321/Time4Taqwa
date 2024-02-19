import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/custom_textformfield.dart';

class CustomDialogBox {
  static Future<bool> deletePostDialogBox({
    required BuildContext context,
    required void Function()? ontap,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Post Confirmation'),
        content: const Text(
            'Are you sure you want to delete this post? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: ontap,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  static Future<bool> logoutDialogBox(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.offAll(() => const SegregationPage());
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  static Future<bool> paymentDialogBox({
    required BuildContext context,
    required TextEditingController controller,
    required void Function()? ontap,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Donation Details'),
        content: CustomTextFormField(
            controller: controller,
            hint: "Enter Amount",
            maxLines: 1,
            minLines: 1,
            keyboardType: TextInputType.number,
            labelText: "Amount"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: ontap,
            child: const Text('Donate'),
          ),
        ],
      ),
    );
  }
}
