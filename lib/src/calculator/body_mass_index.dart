part of '../../medical_calculator.dart';

/// Convert a [Mass] and [Length] to a [BodyMassIndex].
///
/// Example 1:
/// ```dart
/// final bmi = BodyMassIndex(weight: Kilograms(60), height: Centimeters(167));
/// print(bmi);
/// ```
///
/// Example 2:
/// ```dart
/// final bmi = BodyMassIndex(weight: Kilograms(60), height: [Foot(5), Inches(60)].toFoot);
/// print(bmi);
/// ```
///
final class BodyMassIndex extends Equation {
  factory BodyMassIndex({
    required Mass weight,
    required Length height,
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

    final defaultHeight = height.toMeters.value!;
    final defaultWeight = weight.toKilograms.value!;

    final value = defaultWeight / (defaultHeight * defaultHeight);
    final valueWithPrecision = value.toPrecision(decimalPrecision.value);
    final interpretation = valueWithPrecision < 18.5
        ? 'Underweight'
        : valueWithPrecision < 25
            ? 'Normal'
            : valueWithPrecision < 30
                ? 'Overweight'
                : valueWithPrecision < 35
                    ? 'Class 1 Obesity'
                    : valueWithPrecision < 40
                        ? 'Class 2 Obesity'
                        : 'Class 3 Obesity';

    return BodyMassIndex._(
      valueWithPrecision,
      interpretation: interpretation,
    );
  }

  BodyMassIndex._(
    this._value, {
    String symbol = 'kg/m²',
    String? interpretation,
    String? notes =
        "For adults only (18 years and older), using Quetelet's Index",
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
