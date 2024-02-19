import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/prayer_iqama_widget.dart';

class MasjidDetailPage extends StatelessWidget {
  final String masjidname, fajar, zuhar, maghrib, isha, jummah, asar;

  const MasjidDetailPage(
      {super.key,
      required this.masjidname,
      required this.fajar,
      required this.zuhar,
      required this.maghrib,
      required this.isha,
      required this.jummah,
      required this.asar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      masjidname,
                      style: TextStyle(
                          color: AppColors.whitecolor, fontSize: 22.sp),
                    ),
                  ),
                  20.h.verticalSpace,
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
                        Text("Prayer",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),
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
                      border:
                          Border.all(color: AppColors.drawerColor, width: 3),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(17.r),
                          bottomRight: Radius.circular(17.r)),
                    ),
                    child: Column(
                      children: [
                        PrayerIqamaWidget(
                          iqama: fajar,
                          prayer: "Fajar",
                        ),
                        PrayerIqamaWidget(
                          iqama: zuhar,
                          prayer: "Dhuhar",
                        ),
                        PrayerIqamaWidget(
                          iqama: asar,
                          prayer: "Asar",
                        ),
                        PrayerIqamaWidget(
                          iqama: maghrib,
                          prayer: "Maghrib",
                        ),
                        PrayerIqamaWidget(
                          iqama: isha,
                          prayer: "Isha",
                        ),
                        PrayerIqamaWidget(
                          iqama: jummah,
                          prayer: "Jummah",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
