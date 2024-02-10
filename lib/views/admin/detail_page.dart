import 'package:time4taqwa/exportall.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        30.h.verticalSpace,
        // 20.h.verticalSpace,
        Container(
          height: 50.h,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.drawerColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17.r),
                topRight: Radius.circular(17.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 30.w.horizontalSpace,
              Text("Prayer",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),
              // 100.w.horizontalSpace,
              Text("Iqama",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),
            ],
          ).paddingSymmetric(
            horizontal: 48.w,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            // color: AppColors.drawerColor,
            border: Border.all(color: AppColors.drawerColor, width: 3),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(17.r),
                bottomRight: Radius.circular(17.r)),
          ),
          child: const Column(
            children: [
              PrayerIqamaWidget(
                iqama: "10:30 Am",
                prayer: "Fajar",
              ),
              PrayerIqamaWidget(
                iqama: "7:30 Am",
                prayer: "Dhuhar",
              ),
              PrayerIqamaWidget(
                iqama: "7:30 Am",
                prayer: "Asar",
              ),
              PrayerIqamaWidget(
                iqama: "7:30 Am",
                prayer: "Maghrib",
              ),
              PrayerIqamaWidget(
                iqama: "7:30 Am",
                prayer: "Isha",
              ),
            ],
          ),
        ),
        30.h.verticalSpace,
      ]).paddingSymmetric(horizontal: 20.w),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: Get.width,
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColors.lightTextColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Center(
              child: Text(
            "Edit Timings",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                fontSize: 16.sp),
          )),
        ).paddingSymmetric(vertical: 40.h, horizontal: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class PrayerIqamaWidget extends StatelessWidget {
  final String prayer, iqama;
  const PrayerIqamaWidget({
    super.key,
    required this.prayer,
    required this.iqama,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(prayer,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            )),
        Text(iqama,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ))
      ],
    ).paddingSymmetric(horizontal: 48.w, vertical: 20.h);
  }
}
