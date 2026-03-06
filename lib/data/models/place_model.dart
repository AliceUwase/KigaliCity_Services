import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final String id;
  final String name;
  final String address;
  final String phone;
  final double rating;
  final String category;
  final String description;
  final String? latitude;
  final String? longitude;
  final String? imageUrl;
  final String? userId;
  final DateTime? timestamp;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.rating = 0.0,
    required this.category,
    required this.description,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.userId,
    this.timestamp,
  });

  factory Place.fromMap(Map<String, dynamic> map, String id) {
    return Place(
      id: id,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      category: map['category'] ?? 'Other',
      description: map['description'] ?? '',
      latitude: map['latitude'],
      longitude: map['longitude'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] is Timestamp
                ? (map['timestamp'] as Timestamp).toDate()
                : DateTime.tryParse(map['timestamp'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'rating': rating,
      'category': category,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'userId': userId,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
    };
  }

  Place copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    double? rating,
    String? category,
    String? description,
    String? latitude,
    String? longitude,
    String? imageUrl,
    String? userId,
    DateTime? timestamp,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
