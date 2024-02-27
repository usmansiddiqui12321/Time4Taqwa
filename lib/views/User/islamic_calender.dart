import 'package:flutter/material.dart';
import 'package:jhijri_picker/_src/_jWidgets.dart';
import 'package:jhijri/jHijri.dart';
import 'package:time4taqwa/constants/app_colors.dart';

class HijriDatePickerScreen extends StatelessWidget {
  const HijriDatePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hijri Date Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructional Message for Users
            const Text(
              "Select a date using the calendar below to get the corresponding Islamic Date:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // JGlobalDatePicker Widget for selecting Hijri dates
            JGlobalDatePicker(
              widgetType: WidgetType.JContainer,
              pickerType: PickerType.JHijri,
              buttons: const SizedBox(),
              primaryColor: Colors.blue,
              calendarTextColor: Colors.white,
              backgroundColor: AppColors.containerColor,
              borderRadius: const Radius.circular(10),
              startDate: JDateModel(dateTime: DateTime.parse("1984-12-24")),
              selectedDate: JDateModel(dateTime: DateTime.now()),
              endDate: JDateModel(dateTime: DateTime.parse("2030-09-20")),
              pickerMode: DatePickerMode.day,
              pickerTheme: Theme.of(context),
              textDirection: TextDirection.rtl,
              onChange: (val) {
                debugPrint(val.toString());
              },
            ),
            const SizedBox(height: 32),
            // Button to trigger the native date picker
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  final arabicHijriDate =
                      HijriDate.dateToHijri(selectedDate).toString();
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Selected Hijri Date'),
                      content: Text(arabicHijriDate),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: const Text(
                'Select Date',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
