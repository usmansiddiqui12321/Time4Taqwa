import 'package:time4taqwa/exportall.dart';

class MasjidDetailPage extends StatelessWidget {
  final String masjidname;
  final List<String> masjidtimings;

  const MasjidDetailPage(
      {super.key, required this.masjidname, required this.masjidtimings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 225.h,
            width: Get.width,
            decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/masjidbackground.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r))),
          ),
       
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                Text(
                  masjidname,
                  style:
                      TextStyle(color: AppColors.whitecolor, fontSize: 22.sp),
                ),
                Text(
              "",
                  style:
                      TextStyle(color: AppColors.whitecolor, fontSize: 22.sp),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
