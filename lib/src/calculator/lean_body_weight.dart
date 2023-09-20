part of '../../medical_calculator.dart';

final class LeanBodyWeight extends Equation {
  factory LeanBodyWeight({
    required Mass weight,
    required Length height,
    required Gender gender,
    Precision decimalPrecision = Precision.two,
  }) {
    if (weight.value == null) {
      throw ArgumentError.notNull('weight');
    }
    if (height.value == null) {
      throw ArgumentError.notNull('heigth');
    }
    if (weight.value! <= 0 || height.value! <= 0) {
      throw ArgumentError('weight and height must be greater than zero');
    }

    final defaultWeight = weight.toKilograms.value!;

    final properties1 = gender == Gender.male ? 6680 : 8780;
    final properties2 = gender == Gender.male ? 216 : 244;

    final bmi = BodyMassIndex(
      weight: weight,
      height: height,
      decimalPrecision: Precision.nine,
    );

    final value =
        (9270 * defaultWeight) / (properties1 + (properties2 * bmi.value));
    final valueWithPrecision = value.toPrecision(decimalPrecision.value);

    return LeanBodyWeight._(valueWithPrecision);
  }

  LeanBodyWeight._(
    this._value, {
    String symbol = 'kg',
    String? interpretation,
    String? notes = '''
    - The formula depicted, which is based on gender, total body weight, and height, can be used to estimate LBW for adult males or females who are of normal weight or obese.
    - This calculation is not applicable to individuals with abnormal body water composition (eg, fluid overload).
    - This calculation is not validated in individuals at extremes of height, in those with highly muscular builds, or in underweight individuals.
    - The equation on which the calculation was based was derived from data on a population of individuals with bodyweights up to 216.5 kg or body mass index (BMI) up to 69.9 kg/m2 but was not validated in individuals weighing greater than 131.7 kg or with BMI over 38.4 kg/m2.
    - A separate calculator is available for estimating ideal body weight (method of Devine) and adjusted dosing weight.
    ''',
  })  : _interpretation = interpretation,
        _notes = notes,
        _symbol = symbol,
        super(
          _value,
          symbol: symbol,
          interpretation: interpretation,
          notes: notes,
        );

  num _value;

  @override
  num get value => _value;

  String? _interpretation;

  @override
  String? get interpretation => _interpretation;

  String? _symbol;

  @override
  String? get symbol => _symbol;

  String? _notes;

  @override
  String? get notes => _notes;

  @override
  String toString() => '$value $symbol';
}
