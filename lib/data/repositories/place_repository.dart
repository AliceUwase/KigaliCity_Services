import '../models/place_model.dart';

class PlaceRepository {
  final List<Place> _places = [];

  Future<List<Place>> getAllPlaces() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_places);
  }

  Future<void> addPlace(Place place) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _places.add(place);
  }

  Future<void> updatePlace(Place updatedPlace) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _places.indexWhere((p) => p.id == updatedPlace.id);
    if (index != -1) {
      _places[index] = updatedPlace;
    }
  }

  Future<void> deletePlace(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _places.removeWhere((p) => p.id == id);
  }
}
