import 'package:flutter/material.dart';

class ServiceCategory {
  final String id;
  final String name;
  final String iconPath;
  final Color color;
  final int placeCount;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.color,
    required this.placeCount,
  });
}
