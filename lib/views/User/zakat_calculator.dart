import 'package:time4taqwa/exportall.dart';
import 'package:time4taqwa/widgets/custom_textformfield.dart';

class ZakatCalculatorScreen extends StatefulWidget {
  const ZakatCalculatorScreen({super.key});

  @override
  State<ZakatCalculatorScreen> createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  TextEditingController savingsController = TextEditingController();
  TextEditingController debtsController = TextEditingController();
  double totalWealth = 0.0;
  double zakatAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zakat Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your financial details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              controller: savingsController,
              maxLines: 1,
              labelText: "Savings",
              hint: "Enter Your Total Savings",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              controller: debtsController,
              labelText: "Debts",
              maxLines: 1,
              hint: "Enter Total Debts",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: calculateZakat,
                child: const Text('Calculate Zakat'),
              ),
            ),
            20.h.verticalSpace,
            Row(
              children: [
                Text(
                  "Total Wealth: ",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                Text(
                  'Rs${totalWealth.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
            10.h.verticalSpace,
            Row(
              children: [
                Text(
                  "Zakat Amount: ",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                Text(
                  ' Rs${zakatAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            )
            // const SizedBox(height: 16.0),
            // Text('Total Wealth: Rs${totalWealth.toStringAsFixed(2)}'),
            // Text(),
          ],
        ),
      ),
    );
  }

  void calculateZakat() {
    double savings = double.tryParse(savingsController.text) ?? 0.0;
    double debts = double.tryParse(debtsController.text) ?? 0.0;

    setState(() {
      totalWealth = savings - debts;
      zakatAmount = totalWealth * 0.025; // 2.5% of total wealth in PKR
    });
  }
}
