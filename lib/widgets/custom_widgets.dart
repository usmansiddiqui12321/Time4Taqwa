import 'package:time4taqwa/exportall.dart';

class CustomWidgets {
  static CircularProgressIndicator isloading = const CircularProgressIndicator(
    color: AppColors.whitecolor,
  );
  static SnackbarController customsnackbar(
          {required String message, required bool isError}) =>
      Get.snackbar(isError ? "Error" : "Success", message,
          backgroundColor: isError ? Colors.red[400] : Colors.green[400]);
}

class NeumorphicSearchField extends StatelessWidget {
  final void Function(String)? onSearchChanged;
  final TextEditingController searchController;
  const NeumorphicSearchField(
      {super.key, required this.searchController, this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return PrimaryContainer(
      child: TextFormField(
        focusNode: focus,
        onTapOutside: (val) {
          if (kDebugMode) {
            print('onTapOutside');
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: onSearchChanged,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 3),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'Search',
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          suffixIcon: Container(
            width: 70,
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0XFF5E5E5E),
                  Color(0XFF3E3E3E),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(30)),
            child: const Icon(Icons.search, color: AppColors.lightTextColor),
          ),
        ),
      ),
    );
  }
}

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const PrimaryContainer({
    super.key,
    this.radius,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        boxShadow: [
          BoxShadow(
            color: color ?? const Color(0XFF1E1E1E),
          ),
          const BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: AppColors.kGrey100,
          ),
        ],
      ),
      child: child,
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
      maxLines: 6,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      controller: TextEditingController(),
      decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'Text Here',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }
}
