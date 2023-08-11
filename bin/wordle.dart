// Basic requirements:
// - generate a random word from a list of words
// - validate user's input
// - if the input is 5 letters
// - does any of the letters match, are they in the right position
// - if the user guessed the word, print out a winning message
// - if the user didn't guess the word, print out the answer
// Stretch goals:
// - read words from a file and mimic api delay
// - implement a interface or a record
// helpful links:
// https://api.dart.dev/stable/3.0.7/dart-math/dart-math-library.html
// https://api.dart.dev/stable/3.0.7/dart-io/dart-io-library.html
import 'dart:io';

void main() {
  print('Welcome to Wordle!');

  const wordList = [
    'water',
    'jello',
    'empty',
    'donut',
    'melon',
    'truck',
    'lemon'
  ];
  int attempts = 6;

  while (attempts > 0) {
    attempts--;
  }

  print('Game over! The word was: ...');
}
