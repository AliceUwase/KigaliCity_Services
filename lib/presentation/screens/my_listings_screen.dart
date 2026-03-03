import 'package:flutter/material.dart';
import '../widgets/place_card.dart';
import 'add_listing_screen.dart';
import 'place_details_screen.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Listings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '18 total',
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // List of user listings
                  PlaceCard(
                    name: 'King Faisal Hospital',
                    address: 'KG 544 St, Kigali',
                    phone: '+250 788 123 000',
                    rating: 4.5,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaceDetailsScreen(
                            place: {
                              'name': 'King Faisal Hospital',
                              'address': 'KG 544 St, Kigali',
                              'phone': '+250 788 123 000',
                              'rating': 4.5,
                              'description':
                                  'Leading tertiary referral hospital in Rwanda offering comprehensive medical services including emergency care, surgery, maternity, and specialized treatments.',
                              'latitude': '-1.9536',
                              'longitude': '30.0927',
                            },
                          ),
                        ),
                      );
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddListingScreen(
                            place: {
                              'name': 'King Faisal Hospital',
                              'address': 'KG 544 St, Kigali',
                              'phone': '+250 788 123 000',
                              'rating': 4.5,
                              'category': 'Hospital',
                              'description':
                                  'Leading tertiary referral hospital in Rwanda offering comprehensive medical services including emergency care, surgery, maternity, and specialized treatments.',
                              'latitude': '-1.9536',
                              'longitude': '30.0927',
                            },
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      _showDeleteDialog(context, 'King Faisal Hospital');
                    },
                  ),
                  PlaceCard(
                    name: 'Rwanda Military Hospital',
                    address: 'KN 4 Ave, Kigali',
                    phone: '+250 788 123 001',
                    rating: 4.5,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaceDetailsScreen(
                            place: {
                              'name': 'Rwanda Military Hospital',
                              'address': 'KN 4 Ave, Kigali',
                              'phone': '+250 788 123 001',
                              'rating': 4.5,
                              'description':
                                  'Comprehensive healthcare services for military personnel and the general public, providing high-quality medical treatment.',
                              'latitude': '-1.9644',
                              'longitude': '30.1234',
                            },
                          ),
                        ),
                      );
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddListingScreen(
                            place: {
                              'name': 'Rwanda Military Hospital',
                              'address': 'KN 4 Ave, Kigali',
                              'phone': '+250 788 123 001',
                              'rating': 4.5,
                              'category': 'Hospital',
                              'description':
                                  'Comprehensive healthcare services for military personnel and the general public, providing high-quality medical treatment.',
                              'latitude': '-1.9644',
                              'longitude': '30.1234',
                            },
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      _showDeleteDialog(context, 'Rwanda Military Hospital');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String placeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Delete Listing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Are you sure you want to delete this listing? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleting $placeName...'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF1557F2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Listings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Browse and manage all places',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFF1557F2)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddListingScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
