import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlaceCard extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final double rating;
  final String imageUrl;
  final String? userId; // Added userId for ownership check
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PlaceCard({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
    required this.rating,
    this.imageUrl = '',
    this.userId,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the current user is the owner
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final bool isOwner = userId != null && currentUserId == userId;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Side: Name and Address
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          address,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Right Side: Actions + Chevron
            const SizedBox(width: 8),
            // Only show edit/delete if the user is the owner
            if (isOwner && (onEdit != null || onDelete != null)) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF1557F2),
                        size: 20,
                      ),
                      onPressed: onEdit,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  if (onEdit != null && onDelete != null)
                    const SizedBox(width: 12),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: onDelete,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  const SizedBox(width: 12),
                ],
              ),
            ],
            if (!isOwner || (onEdit == null && onDelete == null))
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}
