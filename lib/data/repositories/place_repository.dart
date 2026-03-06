import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/place_model.dart';

class PlaceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'places';

  Stream<List<Place>> getPlacesStream() {
    return _firestore
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Place.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  // Fallback for one-time fetch if needed
  Future<List<Place>> getAllPlaces() async {
    final snapshot = await _firestore
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Place.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addPlace(Place place) async {
    await _firestore.collection(_collection).add(place.toMap());
  }

  Future<void> updatePlace(Place updatedPlace) async {
    await _firestore
        .collection(_collection)
        .doc(updatedPlace.id)
        .update(updatedPlace.toMap());
  }

  Future<void> deletePlace(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}
