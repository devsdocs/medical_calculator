part of '../../medical_calculator.dart';

final class AdjustedBodyWeight extends Equation {
  factory AdjustedBodyWeight({
    required Gender gender,
    required Length height,
    required Mass weight,
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
    if (height.toFeet.value! < 5) {
      throw ArgumentError(
        'equations are applicable to patients with height >= 5 feet',
      );
    }

    final ibw = IdealBodyWeight(
      gender: gender,
      height: height,
      decimalPrecision: Precision.nine,
    ).value;

    final value = ibw + (0.4 * (weight.toKilograms.value! - ibw));
    final valueWithPrecision = value.toPrecision(decimalPrecision.value);

    return AdjustedBodyWeight._(valueWithPrecision);
  }

  AdjustedBodyWeight._(
    this._value, {
    String symbol = 'kg',
    String? interpretation,
    String notes = '''
- Adjusted body weight (AdjBW, also known as “adjusted dosing weight”) may be used to determine weight-based dosing for some medications and in some estimates of kidney function. These equations are applicable to patients ≥5 feet (≥152.4 cm). For patients who weigh less than their IBW, actual (total) body weight is generally used.
- Calculating IBW is the first step in determining AdjBW.
AdjBW is calculated using the formula:[3] AdjBW = IBW + (0.4 * [Actual weight - IBW]).
- AdjBW is a calculated weight that accounts for the incomplete distribution of certain drugs to non-lean body tissues in obesity.
- AdjBW may be useful for calculating an initial dose of aminoglycosides, daptomycin, lidocaine, and certain intravenous anesthetic agents in patients with a high body mass index (BMI).
- This calculator reports an AdjBW of “N/A” for patients whose weight is >IBW but <120% of IBW, since the appropriate adjustment factor for patients in this weight range is unclear.
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
