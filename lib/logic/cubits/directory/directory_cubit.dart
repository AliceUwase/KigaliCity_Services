import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'directory_state.dart';
import '../../../data/models/place_model.dart';
import '../../../data/repositories/place_repository.dart';

class DirectoryCubit extends Cubit<DirectoryState> {
  final PlaceRepository _repository;
  StreamSubscription? _subscription;

  DirectoryCubit(this._repository) : super(DirectoryState.initial()) {
    _subscribeToPlaces();
  }

  void _subscribeToPlaces() {
    _subscription?.cancel();
    _subscription = _repository.getPlacesStream().listen((places) {
      emit(state.copyWith(allPlaces: places));
    });
  }

  void selectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> addPlace(Place place) async {
    await _repository.addPlace(place);
  }

  Future<void> updatePlace(Place updatedPlace) async {
    await _repository.updatePlace(updatedPlace);
  }

  Future<void> deletePlace(String id) async {
    await _repository.deletePlace(id);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
