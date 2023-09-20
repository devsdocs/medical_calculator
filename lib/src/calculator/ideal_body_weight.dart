part of '../../medical_calculator.dart';

final class IdealBodyWeight extends Equation {
  factory IdealBodyWeight({
    required Gender gender,
    required Length height,
    IdealBodyWeightFormula formula = IdealBodyWeightFormula.devine,
    Precision decimalPrecision = Precision.two,
  }) {
    if (height.value == null) {
      throw ArgumentError.notNull('heigth');
    }
    if (height.value! <= 0) {
      throw ArgumentError('height must be greater than zero');
    }
    if (height.toFeet.value! < 5) {
      throw ArgumentError(
        'equations are applicable to patients with height >= 5 feet',
      );
    }
    final baseWeigth = gender == Gender.male
        ? formula.maleBaseWeight
        : formula.femaleBaseWeight;

    final scalar =
        gender == Gender.male ? formula.maleScalar : formula.femaleScalar;

    final scale = scalar * (height.toInches.value! - 60);

    final value = baseWeigth + scale;
    final valueWithPrecision =
        value.toDouble().toPrecision(decimalPrecision.value);

    final defaultHeight = height.toMeters.value!;

    final floorAndCeilingOfNormalBMIWeight = [18.5, 24.9]
        .map((e) => (e * (defaultHeight * defaultHeight)).toPrecision(2))
        .join('-');

    return IdealBodyWeight._(
      valueWithPrecision,
      interpretation:
          'Healthy weight range based on BMI is $floorAndCeilingOfNormalBMIWeight kg',
    );
  }

  IdealBodyWeight._(
    this._value, {
    String symbol = 'kg',
    String? interpretation,
    String notes = '''
- Ideal body weight (IBW) may be used to determine weight-based dosing for some medications and in some estimates of kidney function. These equations are applicable to patients ≥5 feet (≥152.4 cm). For patients who weigh less than their IBW, actual (total) body weight is generally used.
- Before use of these estimates, consult appropriate sources, including clinical drug reference(s) and institutional protocols; different equations are available and recommendations vary locally.
- IBW is estimated by the following equations:[1] Males: IBW (kg) = 50 kg + 2.3 kg for each inch over 5 feet. Females: IBW (kg) = 45.5 kg + 2.3 kg for each inch over 5 feet.
- IBW is sometimes used for calculating an initial weight-based dose of medications distributed primarily to non-adipose tissues, such as acyclovir, digoxin, rocuronium, and vecuronium. IBW may also be used for initial weight-based dosing for intravenous sedatives and opioids, with subsequent doses titrated to effect. For aminoglycosides, IBW may be used for determining the initial dose in patients who weigh from 1 to 1.25 times their IBW.[2,3]
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
  String toString() => '$value $symbol, $interpretation';
}

enum IdealBodyWeightFormula {
  robinson._(
    52,
    1.9,
    49,
    1.7,
  ),
  miller._(
    56.2,
    1.41,
    53.1,
    1.36,
  ),
  devine._(
    50,
    2.3,
    45.5,
    2.3,
  ),
  hamwi._(
    48,
    2.7,
    45.5,
    2.2,
  );

  const IdealBodyWeightFormula._(
    this.maleBaseWeight,
    this.maleScalar,
    this.femaleBaseWeight,
    this.femaleScalar,
  );

  final num maleBaseWeight;
  final num maleScalar;
  final num femaleBaseWeight;
  final num femaleScalar;
}
