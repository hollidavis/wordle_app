// Basic requirements:
// - generate a random word from a list of words
// - validate user's input
// - if the input is 5 letters
// - do any of the letters match? are they in the right position
// - if the user guessed the word, print a winning message
// - if the user didn't guess the word, print the answer
// Stretch goals:
// - read words from a file and mimic api delay
// - implement a interface or a record
// helpful links:
// https://api.dart.dev/stable/3.0.7/dart-math/dart-math-library.html
// https://api.dart.dev/stable/3.0.7/dart-io/dart-io-library.html
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wordle/words.dart';
import 'package:wordle/api_key.dart';

void main() async {
  final response = await http.get(
      Uri.parse("https://wordle-answers-solutions.p.rapidapi.com/today"),
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'wordle-answers-solutions.p.rapidapi.com'
      });

  var decodedResponse = jsonDecode(response.body);

  print('\u001b[1mWelcome to Wordle! 👋\u001b[0m');

  int attempts = 6;

  List<String> pastGuesses = [];

  // generate a random word from a list of words
  // final selectedWord = words[Random().nextInt(words.length)];
  final selectedWord = decodedResponse["today"];

  // validate user's input
  String? getInput() {
    String? input = stdin.readLineSync();
    print('');
    return input?.toUpperCase().trim();
  }

  while (attempts > 0) {
    print('Guess the word (5 letters):');
    final guess = getInput();

    // validate user's input
    if (guess == null || guess.length != 5) {
      print(
          '\u001b[31m❌ Invalid input. Please enter a 5-letter word.\u001b[0m');
      continue;
    }

    // do any of the letters match? are they in the right position?
    var correctPositions = 0;
    var correctStr = '';
    for (var i = 0; i < selectedWord.length; i++) {
      // If the letter is in the right position
      if (guess[i] == selectedWord[i]) {
        correctPositions++;
        correctStr += '\u001b[32m${guess[i]}\u001b[0m';
        // If the letter is in the word
      } else if (selectedWord.contains(guess[i])) {
        correctStr += '\u001b[33m${guess[i]}\u001b[0m';
        // If the letter is not in the word
      } else {
        correctStr += '\u001b[31m${guess[i]}\u001b[0m';
      }
    }

    // if the user guessed the word, print out a winning message
    if (correctPositions == 5) {
      print('\u001b[32m🎉 Congratulations, you won!\u001b[0m');
      break;
    } else {
      // print out the past guesses
      for (var i = 0; i < pastGuesses.length; i++) {
        print(pastGuesses[i]);
      }
      // print out the current guess
      print('$correctStr');
      pastGuesses.add(correctStr);
      // print out the number of attempts remaining
      print(
          '\u001b[31m❌ Incorrect. You have ${--attempts} attempts remaining.\u001b[0m');
      print('');
    }
  }

  // if the user didn't guess the word, print out the answer
  if (attempts == 0) {
    print(
        '\u001b[31m😵 Game over, you ran out of attempts. The word was: $selectedWord\u001b[0m');
  }
}
