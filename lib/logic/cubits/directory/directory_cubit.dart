import 'package:flutter_bloc/flutter_bloc.dart';
import 'directory_state.dart';
import '../../../data/models/place_model.dart';
import '../../../data/repositories/place_repository.dart';

class DirectoryCubit extends Cubit<DirectoryState> {
  final PlaceRepository _repository;

  DirectoryCubit(this._repository) : super(DirectoryState.initial()) {
    fetchPlaces();
  }

  Future<void> fetchPlaces() async {
    final places = await _repository.getAllPlaces();
    emit(state.copyWith(allPlaces: places));
  }

  void selectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void addPlace(Place place) {
    final updatedList = List<Place>.from(state.allPlaces)..add(place);
    emit(state.copyWith(allPlaces: updatedList));
  }

  void updatePlace(Place updatedPlace) {
    final updatedList = state.allPlaces.map((p) {
      return p.id == updatedPlace.id ? updatedPlace : p;
    }).toList();
    emit(state.copyWith(allPlaces: updatedList));
  }

  void deletePlace(String id) {
    final updatedList = state.allPlaces.where((p) => p.id != id).toList();
    emit(state.copyWith(allPlaces: updatedList));
  }
}
