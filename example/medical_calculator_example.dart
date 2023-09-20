import 'package:medical_calculator/medical_calculator.dart';
import 'package:super_measurement/super_measurement.dart';

void main() {
  final globalWeight = Kilograms(82);
  final globalHeigth = Centimeters(167);

  final bmi = BodyMassIndex(weight: globalWeight, height: globalHeigth);
  print(bmi);

  for (final equation in BodySurfaceAreaFormula.values) {
    final bsa = BodySurfaceArea(
      weight: globalWeight,
      height: globalHeigth,
      formula: equation,
    );
    print('Body Surface Area using ${equation.name} => $bsa');
  }

  for (final gender in Gender.values) {
    final lbw = LeanBodyWeight(
      weight: globalWeight,
      height: globalHeigth,
      gender: gender,
    );
    print('Lean Body Weight in ${gender.name} => $lbw');

    final abw = AdjustedBodyWeight(
      gender: gender,
      height: globalHeigth,
      weight: globalWeight,
    );

    print('Adjusted Body Weight in ${gender.name} => $abw');

    for (final formula in IdealBodyWeightFormula.values) {
      final ibw = IdealBodyWeight(
        gender: gender,
        height: globalHeigth,
        formula: formula,
      );

      print('Ideal Body Weight in ${gender.name} use ${formula.name} => $ibw');
    }
  }
}
