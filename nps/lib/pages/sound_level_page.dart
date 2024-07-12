import 'package:flutter/material.dart';
import '../models/frequency_constants.dart';
import '../models/calculation.dart';
import '../helpers/database_helper.dart';
import '../models/sound_level_calculator.dart';

class SoundLevelCalculationPage extends StatefulWidget {
  final String username;

  const SoundLevelCalculationPage({super.key, required this.username});

  @override
  _SoundLevelCalculationPageState createState() =>
      _SoundLevelCalculationPageState();
}

class _SoundLevelCalculationPageState extends State<SoundLevelCalculationPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  String selectedWeighting = 'A';
  double result = 0.0;
  List<double> inputLevels = List.filled(octaveFrequencies.length, 0.0);
  String normMessage = '';

  Future<void> _saveCalculation() async {
    final calculation = Calculation(
      username: widget.username,
      operation: selectedWeighting,
      freq63: inputLevels[0],
      freq125: inputLevels[1],
      freq250: inputLevels[2],
      freq500: inputLevels[3],
      freq1000: inputLevels[4],
      freq2000: inputLevels[5],
      freq4000: inputLevels[6],
      freq8000: inputLevels[7],
      result: result,
      createdAt: DateTime.now().toIso8601String(),
    );

    await _databaseHelper.insertCalculation(calculation);
    print("Calculation saved: ${calculation.toMap()}");
  }

  void _calculateSoundLevel() {
    setState(() {
      result = SoundLevelCalculator.calcularNPS(inputLevels, selectedWeighting);
      normMessage = result <= 85
          ? 'O resultado está dentro das normas.'
          : 'O resultado está fora das normas.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular NPS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedWeighting,
              onChanged: (String? newValue) {
                setState(() {
                  selectedWeighting = newValue!;
                });
              },
              items: <String>['A', 'Z']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: octaveFrequencies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Frequency ${octaveFrequencies[index]} Hz'),
                    trailing: SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            inputLevels[index] = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              'Resultado: ${result.toStringAsFixed(0)} dB',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              normMessage,
              style: TextStyle(
                fontSize: 18,
                color: result <= 85 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _calculateSoundLevel();
                _saveCalculation();
              },
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
