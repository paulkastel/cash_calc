import 'package:cash_calc/views/components/textfield_cash.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('invalid quota should return error message', () {
    const List<String> invalidInputs = [
      ' ',
      'sd',
      'a',
      '!2',
      '%',
      '-',
      '0.',
      '5,1',
      '3d',
      '3.454354353',
      '-34',
      '+99'
    ];
    for (var input in invalidInputs) {
      final String returedInfo = validateInput(input, 'ERROR');
      expect(returedInfo, 'ERROR');
    }
  });
  test('proper number should return null', () {
    const List<String> validInputs = [
      '1',
      '4',
      '732',
      '2232',
      '3.432',
      '34.1',
      '0.0',
      '5.1'
    ];
    for (var input in validInputs) {
      final String returedInfo = validateInput(input, 'ERROR');
      expect(returedInfo, null);
    }
  });
}
