import 'package:fast_reorder/src/ranks_generator.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("Initial rank getting", () {
    expect(RanksGenerator(alphabet: "abcd").getInitialRank(), "b");
    expect(RanksGenerator(alphabet: "abcde").getInitialRank(), "c");
  });

  test("Middle rank generation", () {
    final generator = RanksGenerator(alphabet: "abcde");
    final nextGenerator = RanksGenerator(alphabet: "0123456789abcdefghijklmnopqrstuvwxyz");

    expect(nextGenerator.generateBetween("h08", "h0h"), "h0c");
    expect(nextGenerator.generateBetween("h", "h0h"), "h08");
    expect(nextGenerator.generateBetween("h", "h1"), "h0h");
    expect(nextGenerator.generateBetween("h", "i"), "hh");
    expect(nextGenerator.generateBetween("h", "hh"), "h8");
    expect(nextGenerator.generateBetween("h", "h8"), "h3");
    expect(nextGenerator.generateBetween("h", "h3"), "h1");

    expect(generator.generateBetween("a", "ad"), "ab");
    expect(generator.generateBetween("aa", "ad"), "ab");
    expect(generator.generateBetween("a", "d"), "b");
    expect(generator.generateBetween("a", "b"), "ac");
    expect(generator.generateBetween("ac", "b"), "ad");
    expect(generator.generateBetween("ad", "b"), "ae");
    expect(generator.generateBetween("ae", "b"), "aec");
    expect(generator.generateBetween("aec", "b"), "aed");
    expect(generator.generateBetween("ac", "ca"), "ba");
    expect(generator.generateBetween("ac", "cb"), "bb");
    expect(generator.generateBetween("bc", "bd"), "bcc");
    expect(generator.generateBetween("bc", "be"), "bd");
    expect(generator.generateBetween("e", "ed"), "eb");
    expect(generator.generateBetween("eb", "ed"), "ec");
  });

  test("Next rank generation test", () {
    final generator = RanksGenerator(alphabet: "abcde");

    expect(generator.generateNext("a"), "b");
    expect(generator.generateNext("c"), "d");
    expect(generator.generateNext("ca"), "d");
    expect(generator.generateNext("cb"), "d");
    expect(generator.generateNext("cd"), "d");
    expect(generator.generateNext("ce"), "d");
    expect(generator.generateNext("d"), "e");
    expect(generator.generateNext("da"), "e");
    expect(generator.generateNext("db"), "e");
    expect(generator.generateNext("dc"), "e");
    expect(generator.generateNext("dd"), "e");
    expect(generator.generateNext("de"), "e");
    expect(generator.generateNext("dee"), "e");
    expect(generator.generateNext("e"), "ea");
    expect(generator.generateNext("ea"), "eb");
    expect(generator.generateNext("eb"), "ec");
    expect(generator.generateNext("ebc"), "ec");
    expect(generator.generateNext("ec"), "ed");
    expect(generator.generateNext("ed"), "ee");
    expect(generator.generateNext("ee"), "eea");
    expect(generator.generateNext("eea"), "eeb");
    expect(generator.generateNext("eeb"), "eec");
    expect(generator.generateNext("eec"), "eed");
    expect(generator.generateNext("eed"), "eee");
    expect(generator.generateNext("eee"), "eeea");
  });

  test("Previous rank generation test", () {
    final generator = RanksGenerator(alphabet: "abcde");

    expect(generator.generatePrevious("c"), "b");
    expect(generator.generatePrevious("ca"), "b");
    expect(generator.generatePrevious("b"), "ae");
    expect(generator.generatePrevious("ba"), "ae");
    expect(generator.generatePrevious("baa"), "ae");
    expect(generator.generatePrevious("ae"), "ad");
    expect(generator.generatePrevious("aee"), "ad");
    expect(generator.generatePrevious("ad"), "ac");
    expect(generator.generatePrevious("ac"), "ab");
    expect(generator.generatePrevious("ab"), "aae");
    expect(generator.generatePrevious("aae"), "aad");
    expect(generator.generatePrevious("aad"), "aac");
    expect(generator.generatePrevious("aac"), "aab");
    expect(generator.generatePrevious("aab"), "aaae");
  });
}
