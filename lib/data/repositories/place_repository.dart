import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import '../models/place_model.dart';

class PlaceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'places';

  Stream<List<Place>> getPlacesStream() {
    developer.log('Listening to places stream', name: 'PlaceRepository');
    return _firestore
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          developer.log(
            'Received ${snapshot.docs.length} places from Firestore',
            name: 'PlaceRepository',
          );
          return snapshot.docs.map((doc) {
            return Place.fromMap(doc.data(), doc.id);
          }).toList();
        })
        .handleError((error) {
          developer.log(
            'Error in places stream: $error',
            name: 'PlaceRepository',
            error: error,
          );
          throw error;
        });
  }

  Future<List<Place>> getAllPlaces() async {
    try {
      developer.log('Fetching all places', name: 'PlaceRepository');
      final snapshot = await _firestore
          .collection(_collection)
          .orderBy('timestamp', descending: true)
          .get();
      developer.log(
        'Fetched ${snapshot.docs.length} places',
        name: 'PlaceRepository',
      );
      return snapshot.docs
          .map((doc) => Place.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      developer.log(
        'Error fetching places: $e',
        name: 'PlaceRepository',
        error: e,
      );
      rethrow;
    }
  }

  Future<void> addPlace(Place place) async {
    try {
      developer.log('Adding place: ${place.name}', name: 'PlaceRepository');
      final docRef = await _firestore
          .collection(_collection)
          .add(place.toMap());
      developer.log(
        'Place added with ID: ${docRef.id}',
        name: 'PlaceRepository',
      );
    } catch (e) {
      developer.log(
        'Error adding place: $e',
        name: 'PlaceRepository',
        error: e,
      );
      rethrow;
    }
  }

  Future<void> updatePlace(Place updatedPlace) async {
    try {
      developer.log(
        'Updating place: ${updatedPlace.id}',
        name: 'PlaceRepository',
      );
      await _firestore
          .collection(_collection)
          .doc(updatedPlace.id)
          .update(updatedPlace.toMap());
      developer.log('Place updated successfully', name: 'PlaceRepository');
    } catch (e) {
      developer.log(
        'Error updating place: $e',
        name: 'PlaceRepository',
        error: e,
      );
      rethrow;
    }
  }

  Future<void> deletePlace(String id) async {
    try {
      developer.log('Deleting place: $id', name: 'PlaceRepository');
      await _firestore.collection(_collection).doc(id).delete();
      developer.log('Place deleted successfully', name: 'PlaceRepository');
    } catch (e) {
      developer.log(
        'Error deleting place: $e',
        name: 'PlaceRepository',
        error: e,
      );
      rethrow;
    }
  }
}
