import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package to format dates
import '../models/calculation.dart';
import '../helpers/database_helper.dart';

class HistoryPage extends StatefulWidget {
  final String username;

  const HistoryPage({super.key, required this.username});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Calculation> _calculations = [];

  @override
  void initState() {
    super.initState();
    _getUserCalculations();
  }

  Future<void> _getUserCalculations() async {
    List<Calculation> calculations =
        await _databaseHelper.getUserCalculations(widget.username);
    setState(() {
      _calculations = calculations;
    });
    print(
        "User calculations: ${calculations.map((c) => c.toMap()).toList()}"); // Adicione este print
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Cálculos'),
      ),
      body: _calculations.isEmpty
          ? const Center(child: Text('Nenhum cálculo encontrado.'))
          : ListView.builder(
              itemCount: _calculations.length,
              itemBuilder: (context, index) {
                Calculation calculation = _calculations[index];
                DateTime createdAt = DateTime.parse(calculation.createdAt);
                String formattedDate =
                    DateFormat('dd/MM/yyyy HH:mm').format(createdAt);
                return ListTile(
                  title: Text('Cálculo ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Data: $formattedDate'),
                      const SizedBox(height: 8),
                      Text('Operação: ${calculation.operation}'),
                      const SizedBox(height: 8),
                      const Text('Detalhes:'),
                      DataTable(
                        columns: const [
                          DataColumn(label: Text('Frequência')),
                          DataColumn(label: Text('dB')),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              const DataCell(Text('63 Hz')),
                              DataCell(
                                  Text(calculation.freq63.toStringAsFixed(2))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('125 Hz')),
                              DataCell(
                                  Text(calculation.freq125.toStringAsFixed(2))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('250 Hz')),
                              DataCell(
                                  Text(calculation.freq250.toStringAsFixed(2))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('500 Hz')),
                              DataCell(
                                  Text(calculation.freq500.toStringAsFixed(2))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('1000 Hz')),
                              DataCell(Text(
                                  calculation.freq1000.toStringAsFixed(2))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('2000 Hz')),
                              DataCell(Text(
                                  calculation.freq2000.toStringAsFixed(2))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('4000 Hz')),
                              DataCell(Text(
                                  calculation.freq4000.toStringAsFixed(2))),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('8000 Hz')),
                              DataCell(Text(
                                  calculation.freq8000.toStringAsFixed(2))),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                          'Resultado: ${calculation.result.toStringAsFixed(0)} dB'),
                    ],
                  ),
                  /*onTap: () {
                    // Navigate to detail page for this calculation
                    Navigator.push(
                      context,
                      /MaterialPageRoute(
                        builder: (context) =>
                            CalculationDetailPage(calculation: calculation),
                      ),
                    );
                  },*/
                );
              },
            ),
    );
  }
}

/*class CalculationDetailPage extends StatelessWidget {
  final Calculation calculation;

  const CalculationDetailPage({super.key, required this.calculation});

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = DateTime.parse(calculation.createdAt);
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Cálculo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Data: $formattedDate'),
            const SizedBox(height: 8),
            Text('Operação: ${calculation.operation}'),
            const SizedBox(height: 8),
            const Text('Detalhes:'),
            DataTable(
              columns: const [
                DataColumn(label: Text('Frequência')),
                DataColumn(label: Text('dB')),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text('63 Hz')),
                    DataCell(Text(calculation.freq63.toStringAsFixed(2))),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('125 Hz')),
                    DataCell(Text(calculation.freq125.toStringAsFixed(2))),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('250 Hz')),
                    DataCell(Text(calculation.freq250.toStringAsFixed(2))),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('500 Hz')),
                    DataCell(Text(calculation.freq500.toStringAsFixed(2))),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('1000 Hz')),
                    DataCell(Text(calculation.freq1000.toStringAsFixed(2))),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('2000 Hz')),
                    DataCell(Text(calculation.freq2000.toStringAsFixed(2))),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('4000 Hz')),
                    DataCell(Text(calculation.freq4000.toStringAsFixed(2))),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('8000 Hz')),
                    DataCell(Text(calculation.freq8000.toStringAsFixed(2))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Resultado: ${calculation.result.toStringAsFixed(0)} dB'),
          ],
        ),
      ),
    );
  }
}*/
