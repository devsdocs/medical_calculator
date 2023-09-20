import 'package:medical_calculator/medical_calculator.dart';
import 'package:super_measurement/super_measurement.dart';

void main() {
  final bmi = BodyMassIndex(weight: Kilograms(82), height: Centimeters(167));
  print(bmi);

  final bsa = BodySurfaceArea(
    weight: Kilograms(82),
    height: Centimeters(167),
  );
  print(bsa);

  final lbw = LeanBodyWeight(
    weight: Kilograms(82),
    height: Centimeters(167),
    gender: Gender.male,
  );
  print(lbw);
}
