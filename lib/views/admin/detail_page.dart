import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/views/admin/edit_timings_page.dart';
import 'package:time4taqwa/widgets/prayer_iqama_widget.dart';

class DetailPage extends StatefulWidget {
  final TabController tabController;
  const DetailPage({super.key, required this.tabController});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final authcontroller = Get.put(AuthController());
  @override
  void initState() {
    authcontroller.caretakerloginmodel.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        30.h.verticalSpace,
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
            border: Border.all(color: AppColors.drawerColor, width: 3),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(17.r),
                bottomRight: Radius.circular(17.r)),
          ),
          child: Column(
            children: [
              PrayerIqamaWidget(
                iqama: authcontroller
                        .caretakerloginmodel.value.data?.mosque?.fajar ??
                    "",
                prayer: "Fajar",
              ),
              PrayerIqamaWidget(
                iqama: authcontroller
                        .caretakerloginmodel.value.data?.mosque?.zuhr ??
                    "",

               
                prayer: "Dhuhar",
              ),
              PrayerIqamaWidget(
                iqama: authcontroller
                        .caretakerloginmodel.value.data?.mosque?.asar ??
                    "",
               
                prayer: "Asar",
              ),
              PrayerIqamaWidget(
               
                iqama: authcontroller
                        .caretakerloginmodel.value.data?.mosque?.maghrib ??
                    "",
                prayer: "Maghrib",
              ),
              PrayerIqamaWidget(
                iqama: authcontroller
                        .caretakerloginmodel.value.data?.mosque?.esha ??
                    "",
               
                prayer: "Isha",
              ),
              PrayerIqamaWidget(
                iqama: authcontroller
                        .caretakerloginmodel.value.data?.mosque?.jummah ??
                    "",
               
                prayer: "Jummah",
              ),
            ],
          ),
        ),
        30.h.verticalSpace,
      ]).paddingSymmetric(horizontal: 20.w),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(EditTimingsPage(
            tabController: widget.tabController,
            mosqueId:
                authcontroller.caretakerloginmodel.value.data?.mosque?.id ?? "",
            asar: authcontroller.caretakerloginmodel.value.data?.mosque?.asar ??
                "",
            fajar:
                authcontroller.caretakerloginmodel.value.data?.mosque?.fajar ??
                    "",
            isha: authcontroller.caretakerloginmodel.value.data?.mosque?.esha ??
                "",
            jummah:
                authcontroller.caretakerloginmodel.value.data?.mosque?.jummah ??
                    "",
            maghrib: authcontroller
                    .caretakerloginmodel.value.data?.mosque?.maghrib ??
                "",
            zuhar:
                authcontroller.caretakerloginmodel.value.data?.mosque?.zuhr ??
                    "",
          ));
        },
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
