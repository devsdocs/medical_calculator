import 'package:medical_calculator/medical_calculator.dart';
import 'package:super_measurement/super_measurement.dart';

void main() {
  final globalWeight = Kilograms(82);
  final globalHeigth = Centimeters(167);

  final bmi = BodyMassIndex(weight: globalWeight, height: globalHeigth);
  print(bmi);

  for (final equation in BodySurfaceAreaEquation.values) {
    final bsa = BodySurfaceArea(
      weight: globalWeight,
      height: globalHeigth,
      equation: equation,
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
  }
}
