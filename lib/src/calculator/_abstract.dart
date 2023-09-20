part of '../../medical_calculator.dart';

abstract final class Equation {
  Equation(this.value, {this.symbol, this.interpretation, this.notes});
  num value;
  String? symbol;
  String? interpretation;
  String? notes;
}
