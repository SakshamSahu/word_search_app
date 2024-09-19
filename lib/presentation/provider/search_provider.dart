import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:word_search_app/utils/assets.dart';
//import 'package:word_search_app/utils/assets.dart';
import 'package:word_search_app/utils/widgets/custom_snack_bar.dart';

class SearchProvider extends ChangeNotifier {
  Future<void> onSearch(
    BuildContext context,
    TextEditingController searchController,
    int rows,
    int columns,
    List<String> gridData,
    Function(List<int>) updateHighlightedIndices,
  ) async {
    final searchWord = searchController.text.trim().toUpperCase();
    // Clear the previously highlighted indices first
    updateHighlightedIndices([]);
    if (searchWord.isEmpty) {
      return customSnackBar(context, "Enter a word to search", true);
    }

    final searchResult = _searchWordInGrid(searchWord, rows, columns, gridData);
    final player = AudioPlayer();

    if (searchResult.isNotEmpty) {
      // Word found, play success sound

      try {
        await player
            .play(AssetSource(Assets.sucessSound)); // Await the play function
      } catch (e) {
        // Handle audio playback error (if any)
        print("Error playing success sound: $e");
      }
      updateHighlightedIndices(searchResult);
      customSnackBar(context, "Word Found", false);
    } else {
      // Word not found, play failure sound
      try {
        await player
            .play(AssetSource(Assets.failureSound)); // Await the play function
      } catch (e) {
        // Handle audio playback error (if any)
        print("Error playing failure sound: $e");
      }
      customSnackBar(context, "Word not found", true);
      // Reset highlights back to default (empty list)
      updateHighlightedIndices([]);
    }
  }

  List<int> _searchWordInGrid(
      String word, int rows, int columns, List<String> gridData) {
    // Call the search algorithm and return the list of indices to be highlighted
    final directions = [
      // Horizontal (left to right)
      {'dx': 0, 'dy': 1},
      // Vertical (top to bottom)
      {'dx': 1, 'dy': 0},
      // Diagonal (top left to bottom right)
      {'dx': 1, 'dy': 1},
      // Diagonal (top right to bottom left)
      {'dx': 1, 'dy': -1}
    ];

    for (var direction in directions) {
      final result = _searchInDirection(
          word, direction['dx']!, direction['dy']!, rows, columns, gridData);
      if (result.isNotEmpty) return result;
    }

    return []; // Word not found
  }

  List<int> _searchInDirection(String word, int dx, int dy, int rows,
      int columns, List<String> gridData) {
    final List<int> matchedIndices = [];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        bool match = true;
        for (int k = 0; k < word.length; k++) {
          final newRow = i + k * dx;
          final newCol = j + k * dy;
          if (newRow >= rows || newCol >= columns || newCol < 0) {
            match = false;
            break;
          }
          if (gridData[newRow * columns + newCol] != word[k]) {
            match = false;
            break;
          }
        }
        if (match) {
          for (int k = 0; k < word.length; k++) {
            final newRow = i + k * dx;
            final newCol = j + k * dy;
            matchedIndices.add(newRow * columns + newCol);
          }
          return matchedIndices;
        }
      }
    }
    return [];
  }
}
