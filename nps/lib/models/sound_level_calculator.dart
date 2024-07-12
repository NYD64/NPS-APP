import 'dart:math';
import '../models/frequency_constants.dart';

class SoundLevelCalculator {
  static double calcularNPS(
      List<double> inputLevels, String selectedWeighting) {
    Map<double, double> weightingFactors;

    if (selectedWeighting == 'A') {
      weightingFactors = aWeightingFactors;
    } else {
      weightingFactors = zWeightingFactors;
    }

    double soma = 0.0;
    for (int i = 0; i < inputLevels.length; i++) {
      double frequency = octaveFrequencies[i];
      double weightedLevel = inputLevels[i] + weightingFactors[frequency]!;
      soma += pow(10, weightedLevel / 10);
    }

    return 10 * log(soma) / ln10;
  }
}
