import 'package:equatable/equatable.dart';
import '../../../data/models/place_model.dart';

class DirectoryState extends Equatable {
  final String selectedCategory;
  final String searchQuery;
  final List<Place> allPlaces;

  const DirectoryState({
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.allPlaces = const <Place>[],
  });

  factory DirectoryState.initial() {
    return const DirectoryState(allPlaces: <Place>[]);
  }

  DirectoryState copyWith({
    String? selectedCategory,
    String? searchQuery,
    List<Place>? allPlaces,
  }) {
    return DirectoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      allPlaces: allPlaces ?? this.allPlaces,
    );
  }

  List<Place> get filteredPlaces {
    return allPlaces.where((place) {
      final matchesCategory =
          selectedCategory == 'All' || place.category == selectedCategory;
      final query = searchQuery.toLowerCase();
      final matchesSearch =
          query.isEmpty ||
          place.name.toLowerCase().contains(query) ||
          place.address.toLowerCase().contains(query) ||
          place.description.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  int getCountForCategory(String category) {
    if (category == 'All') return allPlaces.length;
    return allPlaces.where((p) => p.category == category).length;
  }

  @override
  List<Object?> get props => [selectedCategory, searchQuery, allPlaces];
}
