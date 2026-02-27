import 'package:flutter/material.dart';
import '../../data/models/service_category.dart';

class CategoryCard extends StatelessWidget {
  final ServiceCategory category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const Offset(12, 12).dx == 12
                  ? const EdgeInsets.all(12)
                  : EdgeInsets
                        .zero, // Fixing a typo in my thought, actually just use EdgeInsets.all(12)
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconData(category.id),
                color: category.color,
                size: 30,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              '${category.placeCount} places',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String id) {
    switch (id) {
      case 'health':
        return Icons.medical_services_outlined;
      case 'safety':
        return Icons.shield_outlined;
      case 'libraries':
        return Icons.book_outlined;
      case 'utilities':
        return Icons.bolt;
      case 'food_drink':
        return Icons.restaurant;
      case 'recreation':
        return Icons.park_outlined;
      default:
        return Icons.category_outlined;
    }
  }
}
