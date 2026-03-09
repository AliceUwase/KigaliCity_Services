import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/place_model.dart';
import '../../logic/cubits/directory/directory_cubit.dart';
import '../../logic/cubits/directory/directory_state.dart';
import '../widgets/place_card.dart';
import 'add_listing_screen.dart';
import 'place_details_screen.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectoryCubit, DirectoryState>(
      builder: (context, state) {
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;
        final myListings =
            state.allPlaces.where((p) => p.userId == currentUserId).toList();

        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'My Listings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${myListings.length} total',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (state.status == DirectoryStatus.loading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (state.status == DirectoryStatus.error)
                        _buildErrorState(state.errorMessage)
                      else if (myListings.isEmpty)
                        _buildEmptyState(),
                    ],
                  ),
                ),
              ),
              if (state.status == DirectoryStatus.loaded &&
                  myListings.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final place = myListings[index];
                        return PlaceCard(
                          name: place.name,
                          address: place.address,
                          phone: place.phone,
                          rating: place.rating,
                          userId: place.userId,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlaceDetailsScreen(place: place),
                              ),
                            );
                          },
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddListingScreen(place: place),
                              ),
                            );
                          },
                          onDelete: () {
                            _showDeleteDialog(context, place);
                          },
                        );
                      },
                      childCount: myListings.length,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.list_alt, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'You have no listings yet',
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to add your first listing',
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String? message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              message ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Place place) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
                  'Are you sure you want to delete "${place.name}"? This action cannot be undone.',
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
                      context.read<DirectoryCubit>().deletePlace(place.id);
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Listing "${place.name}" deleted'),
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
                    onPressed: () => Navigator.pop(dialogContext),
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
                    'My Listings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Manage your places',
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
