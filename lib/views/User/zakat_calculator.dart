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
            // TextField(
            //   controller: savingsController,
            //   keyboardType: TextInputType.number,
            //   decoration:
            //       const InputDecoration(labelText: 'Total Savings (in USD)'),
            // ),
            CustomTextFormField( controller:savingsController, maxLines: 1 ),
            const SizedBox(height: 16.0),
            TextField(
              controller: debtsController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Total Debts (in USD)'),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: calculateZakat,
              child: const Text('Calculate Zakat'),
            ),
            const SizedBox(height: 16.0),
            Text('Total Wealth: \$${totalWealth.toStringAsFixed(2)}'),
            Text('Zakat Amount: \$${zakatAmount.toStringAsFixed(2)}'),
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
      zakatAmount = totalWealth * 0.025; // 2.5% of total wealth
    });
  }
}
