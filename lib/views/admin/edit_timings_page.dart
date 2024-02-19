import 'package:intl/intl.dart';
import 'package:time4taqwa/controllers/masjidtimecontroller.dart';
import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/custom_textformfield.dart';
import 'package:time4taqwa/widgets/custom_timeformfield.dart';

class EditTimingsPage extends StatefulWidget {
  final String fajar, zuhar, asar, maghrib, isha, jummah, mosqueId;
  final TabController tabController;
  const EditTimingsPage({
    super.key,
    required this.fajar,
    required this.zuhar,
    required this.asar,
    required this.maghrib,
    required this.isha,
    required this.mosqueId,
    required this.jummah,
    required this.tabController,
  });

  @override
  State<EditTimingsPage> createState() => _EditTimingsPageState();
}

class _EditTimingsPageState extends State<EditTimingsPage> {
  final masjidTimeController = Get.put(MasjidTimeController());
  final fajarController = TextEditingController();
  final zuharController = TextEditingController();
  final asarController = TextEditingController();
  final maghribController = TextEditingController();
  final ishaController = TextEditingController();
  final jummahController = TextEditingController();

  @override
  void initState() {
    fajarController.text = widget.fajar;
    zuharController.text = widget.zuhar;
    asarController.text = widget.asar;
    maghribController.text = widget.maghrib;
    ishaController.text = widget.isha;
    jummahController.text = widget.jummah;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Timings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.h.verticalSpace,
              Text(
                "Timings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              15.h.verticalSpace,
              TimePickerWidget(
                controller: fajarController,
                title: 'Fajar',
              ),
              15.h.verticalSpace,
              TimePickerWidget(
                controller: zuharController,
                title: 'Zuhr',
              ),
              15.h.verticalSpace,
              TimePickerWidget(
                controller: asarController,
                title: 'Asar',
              ),
              15.h.verticalSpace,
              TimePickerWidget(
                controller: maghribController,
                title: 'Maghrib',
              ),
              15.h.verticalSpace,
              TimePickerWidget(
                controller: ishaController,
                title: 'Isha',
              ),
              15.h.verticalSpace,
              TimePickerWidget(
                controller: jummahController,
                title: 'Jummah',
              ),
              15.h.verticalSpace,
              masjidTimeController.isloading.value
                  ? Center(child: CustomWidgets.isloading)
                  : GestureDetector(
                      onTap: () {
                        //! HIT API HERE
                        masjidTimeController.updatetimings(
                          fajar: fajarController.text,
                          tabController: widget.tabController,
                          zuhar: zuharController.text,
                          asar: asarController.text,
                          maghrib: maghribController.text,
                          isha: ishaController.text,
                          jummah: jummahController.text,
                          mosqueid: widget.mosqueId,
                        );
                      },
                      child: Container(
                        width: Get.width,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColors.lightTextColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                            child: Text(
                          "Save Timings",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 16.sp),
                        )),
                      ).paddingSymmetric(horizontal: 30),
                    ),
              50.h.verticalSpace,
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ),
    );
  }
}

class TimePickerWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  const TimePickerWidget(
      {super.key, required this.title, required this.controller});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  String formatTime(TimeOfDay time) {
    return DateFormat.jm().format(DateTime(2020, 1, 1, time.hour, time.minute));
  }

  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        8.h.verticalSpace,
        CustomTimeFormField(
          // maxLines: 1,
          onTap: () {
            selectTime(context).then((value) {
              setState(() {
                widget.controller.text = formatTime(_selectedTime);
              });
            });
          },
          controller: widget.controller,
          hint: "Enter ${widget.title} Time here",
          // labelText: "Fajar Time",
        ),
      ],
    );
  }
}
