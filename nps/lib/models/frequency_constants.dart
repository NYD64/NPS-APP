const List<double> octaveFrequencies = [
  63.0,
  125.0,
  250.0,
  500.0,
  1000.0,
  2000.0,
  4000.0,
  8000.0
];

const List<double> aWeightingValues = [
  -26.2,
  -16.1,
  -8.6,
  -3.2,
  0.0,
  1.2,
  1.0,
  -1.1
];

const List<double> zWeightingValues = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

Map<double, double> createWeightingFactors(
    List<double> frequencies, List<double> values) {
  Map<double, double> factors = {};
  for (int i = 0; i < frequencies.length; i++) {
    factors[frequencies[i]] = values[i];
  }
  return factors;
}

final Map<double, double> aWeightingFactors =
    createWeightingFactors(octaveFrequencies, aWeightingValues);
final Map<double, double> zWeightingFactors =
    createWeightingFactors(octaveFrequencies, zWeightingValues);
