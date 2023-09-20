part of '../../medical_calculator.dart';

final class BodySurfaceArea extends Equation {
  factory BodySurfaceArea({
    required Mass weight,
    required Length height,
    Precision decimalPrecision = Precision.two,
    BodySurfaceAreaFormula formula = BodySurfaceAreaFormula.duBoisAndDuBois,
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

    final defaultHeight = height.toCentimeters.value!;
    final defaultWeight = weight.toKilograms.value!;

    double? internalValue;

    if (formula == BodySurfaceAreaFormula.boyd) {
      internalValue = 0.03330 *
          pow(defaultWeight, 0.6157 - (0.0188 * defaultWeight.log10)) *
          pow(defaultHeight, 0.3);
    }
    if (formula == BodySurfaceAreaFormula.duBoisAndDuBois) {
      internalValue =
          pow(defaultWeight, 0.425) * pow(defaultHeight, 0.725) * 0.007184;
    }
    if (formula == BodySurfaceAreaFormula.gehanAndGeorge) {
      internalValue =
          pow(defaultWeight, 0.51456) * pow(defaultHeight, 0.42246) * 0.0235;
    }
    if (formula == BodySurfaceAreaFormula.haycock) {
      internalValue =
          pow(defaultWeight, 0.5378) * pow(defaultHeight, 0.3964) * 0.024265;
    }
    if (formula == BodySurfaceAreaFormula.mosteller) {
      internalValue = sqrt(
        (defaultWeight * defaultHeight) / 3600,
      );
    }
    if (formula == BodySurfaceAreaFormula.yu) {
      internalValue =
          (71.3989 * pow(defaultHeight, 0.7437) * pow(defaultWeight, 0.4040)) /
              10000;
    }
    if (formula == BodySurfaceAreaFormula.livingston) {
      internalValue = 0.1173 * pow(defaultWeight, 0.6466);
    }
    if (formula == BodySurfaceAreaFormula.fujimoto) {
      internalValue =
          0.008883 * pow(defaultWeight, 0.444) * pow(defaultHeight, 0.663);
    }
    if (formula == BodySurfaceAreaFormula.takahira) {
      internalValue =
          0.007241 * pow(defaultWeight, 0.425) * pow(defaultHeight, 0.725);
    }

    final valueWithPrecision =
        internalValue!.toPrecision(decimalPrecision.value);

    return BodySurfaceArea._(valueWithPrecision);
  }

  BodySurfaceArea._(
    this._value, {
    String symbol = 'm²',
    String? interpretation,
    String? notes,
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

enum BodySurfaceAreaFormula {
  boyd,
  duBoisAndDuBois,
  gehanAndGeorge,
  haycock,
  mosteller,
  yu,
  livingston,
  fujimoto,
  takahira;
}
