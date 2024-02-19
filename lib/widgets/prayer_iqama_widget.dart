
import 'package:time4taqwa/exportall.dart';

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
