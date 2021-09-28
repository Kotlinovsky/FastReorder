import 'package:fast_reorder/src/helpers/notation_helper.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final indexes = <String, int>{};
  final alphabet = "0123456789abcdefghijklmnopqrstuvwxyz";

  for (int i = 0; i < alphabet.length; i++) {
    indexes[alphabet[i]] = i;
  }

  test("Converting from 36-radix to 10-radix", () {
    for (int i = 0; i <= 65535 * 256; i++) {
      final string = i.toRadixString(36);
      final result = NotationHelper.convertStringToNumber(indexes, string);

      expect(result, i);
    }
  });

  test("Converting from 10-radix to 36-radix", () {
    for (int i = 0; i <= 65535 * 256; i++) {
      final string = i.toRadixString(36);
      final result = NotationHelper.convertNumberToString(alphabet, i);

      expect(result, string);
    }
  });
}
