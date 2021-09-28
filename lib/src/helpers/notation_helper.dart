import 'dart:collection';

class NotationHelper {
  /// Конвертирует число из N-ричной системы счисления в десятичную
  static int convertStringToNumber(Map<String, int> alphabetIndexes, String string) {
    var radixPow = 1;
    var number = 0;

    for (int i = string.length - 1; i >= 0; i--) {
      final char = string[i];
      final charIndex = alphabetIndexes[char]!;

      number += charIndex * radixPow;
      radixPow *= alphabetIndexes.length;
    }

    return number;
  }

  /// Конвертирует число из 10-ричной системы в N-ричную систему
  static String convertNumberToString(String alphabet, int number) {
    var parts = Queue<String>();

    do {
      parts.addFirst(alphabet[number % alphabet.length]);
      number ~/= alphabet.length;
    } while (number > 0);

    return parts.join();
  }
}
