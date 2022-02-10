import 'package:fast_reorder/src/helpers/notation_helper.dart';
import 'dart:math' as math;

class RanksGenerator {
  final String alphabet;
  final Map<String, int> alphabetIndexes;

  RanksGenerator({
    required this.alphabet,
  }) : alphabetIndexes = _indexAlphabet(alphabet);

  /// Выдает ранг для самого первого элемента списка
  String getInitialRank() => alphabet[(alphabet.length - 1) ~/ 2];

  /// Генерирует ранг между двумя элементами
  String generateBetween(String previousElementRank, String nextElementRank) {
    String resultRank;

    final maxRankLength = math.max(previousElementRank.length, nextElementRank.length);
    final paddedPreviousElementRank = previousElementRank.padRight(maxRankLength, alphabet[0]);
    final paddedNextElementRank = nextElementRank.padRight(maxRankLength, alphabet[0]);
    final previousElementNumber = NotationHelper.convertStringToNumber(alphabetIndexes, paddedPreviousElementRank);
    final nextElementNumber = NotationHelper.convertStringToNumber(alphabetIndexes, paddedNextElementRank);
    final elementsBetweenRanks = nextElementNumber - previousElementNumber - 1;

    if (elementsBetweenRanks < 0) {
      throw ArgumentError("Previous rank cannot be smaller than next rank");
    } else if (elementsBetweenRanks == 0) {
      resultRank = previousElementRank + getInitialRank();
    } else {
      final middleElementNumber = previousElementNumber + (elementsBetweenRanks == 1 ? 1 : (elementsBetweenRanks ~/ 2));
      final middleElementRank = NotationHelper.convertNumberToString(alphabet, middleElementNumber);

      resultRank = middleElementRank.padLeft(previousElementRank.length, alphabet[0]);
    }

    if (resultRank.compareTo(nextElementRank) == 1) {
      return generateBetween(paddedPreviousElementRank, nextElementRank);
    }

    return resultRank;
  }

  /// Генерирует ранг для размещения элемента под элементом с указанным рангом
  String generateNext(String previousElementRank) {
    for (int i = 0; i < previousElementRank.length; i++) {
      if (alphabetIndexes[previousElementRank[i]]! < alphabet.length - 1) {
        return previousElementRank.replaceRange(i, null, "") + alphabet[alphabetIndexes[previousElementRank[i]]! + 1];
      }
    }

    return previousElementRank + getInitialRank();
  }

  /// Генерирует ранг для размещения элемента над элементом с указанным рангом
  String generatePrevious(String nextElementRank) {
    if (nextElementRank.startsWith(alphabet[1])) {
      // B, BA, BC -> AE при алфавите {A, B, C, D}
      return alphabet[0] + alphabet[alphabet.length - 1];
    }

    for (int i = 0; i < nextElementRank.length; i++) {
      if (alphabetIndexes[nextElementRank[i]]! > 0) {
        final result = nextElementRank.replaceRange(i, null, "") + alphabet[alphabetIndexes[nextElementRank[i]]! - 1];

        // Предотвращаем достижение ранка в виде одного первого символа алфавита
        // Для этого удлиняем ранк с помощью последней буквы алфавита
        for (int j = 0; j < result.length; j++) {
          if (result[j] != alphabet[0]) {
            return result;
          }
        }

        return result + alphabet[alphabet.length - 1];
      }
    }

    throw ArgumentError("nextElementRank cannot be equals with the min char of alphabet");
  }

  /// Индексирует алфавит
  static Map<String, int> _indexAlphabet(String alphabet) {
    final map = <String, int>{};

    for (int i = 0; i < alphabet.length; i++) {
      map[alphabet[i]] = i;
    }

    return map;
  }
}
