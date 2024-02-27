import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:time4taqwa/exportall.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint, labelText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const CustomTextFormField(
      {super.key,
      this.hint,
      this.labelText,
      required this.controller,
      this.maxLines,
      this.minLines,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      if (isKeyboardVisible) {
        // when keyboard is visible
      } else {
        // when keyboard is invisible
        SystemChrome.restoreSystemUIOverlays();
      }
      return TextFormField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        controller: controller,
        onTapOutside: (val) {
          if (kDebugMode) {
            print('onTapOutside');
          }
          FocusManager.instance.primaryFocus?.unfocus();
          SystemChrome.restoreSystemUIOverlays();

          // controller.dispose();
        },
        decoration: InputDecoration(
          labelText: labelText,
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
    });
  }
}
