import 'dart:developer';

import 'package:time4taqwa/controllers/namaz_counter.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/custom_dialogboxes.dart';

class QazaNamazCounterScreen extends StatefulWidget {
  QazaNamazCounterScreen({super.key}) {
    // Initialize counts from LocalStorage when the screen is created
  }

  @override
  State<QazaNamazCounterScreen> createState() => _QazaNamazCounterScreenState();
}

class _QazaNamazCounterScreenState extends State<QazaNamazCounterScreen> {
  final NamazController namazController = Get.put(NamazController());

  @override
  void initState() {
    super.initState();
    namazController.fajarCount.value =
        LocalStorage.readjson(key: lsk.fajarNamaz) ?? 0;
    namazController.zuharCount.value =
        LocalStorage.readjson(key: lsk.zuhrNamaz) ?? 0;
    namazController.asarCount.value =
        LocalStorage.readjson(key: lsk.asarNamaz) ?? 0;
    namazController.maghribCount.value =
        LocalStorage.readjson(key: lsk.maghribNamaz) ?? 0;
    namazController.ishaCount.value =
        LocalStorage.readjson(key: lsk.ishaNamaz) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qaza Namaz Counter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildNamazCounterCard(
                    title: "Fajar",
                    value: namazController.fajarCount.value,
                    inc: () {
                      namazController
                          .incrementQazaCount(namazController.fajarCount);
                    },
                    dec: () {
                      namazController
                          .decrementQazaCount(namazController.fajarCount);
                    },
                  ),
                  buildNamazCounterCard(
                    title: "Zuhar",
                    value: namazController.zuharCount.value,
                    inc: () {
                      namazController
                          .incrementQazaCount(namazController.zuharCount);
                    },
                    dec: () {
                      namazController
                          .decrementQazaCount(namazController.zuharCount);
                    },
                  ),
                  buildNamazCounterCard(
                    title: "Asar",
                    value: namazController.asarCount.value,
                    inc: () {
                      namazController
                          .incrementQazaCount(namazController.asarCount);
                    },
                    dec: () {
                      namazController
                          .decrementQazaCount(namazController.asarCount);
                    },
                  ),
                  buildNamazCounterCard(
                    title: "Maghrib",
                    value: namazController.maghribCount.value,
                    inc: () {
                      namazController
                          .incrementQazaCount(namazController.maghribCount);
                    },
                    dec: () {
                      namazController
                          .decrementQazaCount(namazController.maghribCount);
                    },
                  ),
                  buildNamazCounterCard(
                    title: "Isha",
                    value: namazController.ishaCount.value,
                    inc: () {
                      namazController
                          .incrementQazaCount(namazController.ishaCount);
                    },
                    dec: () {
                      namazController
                          .decrementQazaCount(namazController.ishaCount);
                    },
                  ),
                  10.h.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      //Clear All
                      namazController.fajarCount.value = 0;
                      namazController.zuharCount.value = 0;
                      namazController.asarCount.value = 0;
                      namazController.maghribCount.value = 0;
                      namazController.ishaCount.value = 0;
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.transparent;
                          }
                          return Colors.transparent;
                        },
                      ),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                        (Set<MaterialState> states) {
                          return const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          );
                        },
                      ),
                      animationDuration: const Duration(milliseconds: 500),
                    ),
                    child: const Text(
                      "Clear All",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          LocalStorage.writejson(
              key: lsk.fajarNamaz, value: namazController.fajarCount.value);
          LocalStorage.writejson(
              key: lsk.zuhrNamaz, value: namazController.zuharCount.value);
          LocalStorage.writejson(
              key: lsk.asarNamaz, value: namazController.asarCount.value);
          LocalStorage.writejson(
              key: lsk.maghribNamaz, value: namazController.maghribCount.value);
          LocalStorage.writejson(
              key: lsk.ishaNamaz, value: namazController.ishaCount.value);
          log('LOCASTORAGE : ${LocalStorage.readjson(key: lsk.fajarNamaz).toString()}');
          log('Controller ${namazController.fajarCount.value}');
          CustomWidgets.customsnackbar(
              message: "Saved Successfully", isError: false);
          Get.close(1);
        },
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
        ).paddingSymmetric(vertical: 40.h, horizontal: 20.w),
      ),
    );
  }

  Widget buildNamazCounterCard({
    required String title,
    required int value,
    required void Function()? inc,
    required void Function()? dec,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title: ',
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: dec,
                  child: const Icon(Icons.remove),
                ),
                5.w.horizontalSpace,
                Text(
                  value.toString(),
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                5.w.horizontalSpace,
                ElevatedButton(
                  onPressed: inc,
                  child: const Icon(Icons.add),
                ),
                5.w.horizontalSpace,
              ],
            )
          ],
        ),
      ),
    );
  }
}
