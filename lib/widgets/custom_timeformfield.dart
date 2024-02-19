import 'package:time4taqwa/exportall.dart';

class CustomTimeFormField extends StatelessWidget {
  
  final String hint;
  void Function()? onTap;
  final TextEditingController controller;

  CustomTimeFormField({
    super.key,
    this.onTap,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: true,

      onTapOutside: (val) {
        if (kDebugMode) {
          print('onTapOutside');
        }
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.access_time),
        hoverColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 3),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.r)),
        errorBorder: InputBorder.none,
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.r)),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
