import 'package:equatable/equatable.dart';
import '../../../data/models/place_model.dart';

enum DirectoryStatus { initial, loading, loaded, error }

class DirectoryState extends Equatable {
  final DirectoryStatus status;
  final String selectedCategory;
  final String searchQuery;
  final List<Place> allPlaces;
  final String? errorMessage;

  const DirectoryState({
    this.status = DirectoryStatus.initial,
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.allPlaces = const <Place>[],
    this.errorMessage,
  });

  factory DirectoryState.initial() {
    return const DirectoryState(status: DirectoryStatus.initial);
  }

  DirectoryState copyWith({
    DirectoryStatus? status,
    String? selectedCategory,
    String? searchQuery,
    List<Place>? allPlaces,
    String? errorMessage,
  }) {
    return DirectoryState(
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      allPlaces: allPlaces ?? this.allPlaces,
      errorMessage: errorMessage ?? this.errorMessage,
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
  List<Object?> get props => [
    status,
    selectedCategory,
    searchQuery,
    allPlaces,
    errorMessage,
  ];
}
