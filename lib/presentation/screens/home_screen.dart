import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/place_card.dart';
import '../widgets/category_filter_chip.dart';
import '../../logic/cubits/directory/directory_cubit.dart';
import '../../logic/cubits/directory/directory_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _mockData = [
    {
      'name': 'King Faisal Hospital',
      'address': 'KG 544 St, Kigali',
      'phone': '+250 788 123 000',
      'rating': 4.5,
      'category': 'Hospital',
      'description':
          'Advanced medical services and specialized care in Kigali.',
    },
    {
      'name': 'Rwanda Military Hospital',
      'address': 'KN 4 Ave, Kigali',
      'phone': '+250 788 123 001',
      'rating': 4.5,
      'category': 'Hospital',
      'description':
          'Comprehensive healthcare services for military and civilians.',
    },
    {
      'name': 'Heaven Restaurant',
      'address': 'KN 29 St, Kigali',
      'phone': '+250 788 123 002',
      'rating': 4.8,
      'category': 'Restaurant',
      'description': 'Upscale dining with a beautiful view and local flavors.',
    },
    {
      'name': 'Inzora Rooftop Café',
      'address': 'KG 5 Ave, Kigali',
      'phone': '+250 788 123 003',
      'rating': 4.7,
      'category': 'Café',
      'description':
          'Cozy rooftop café perfect for working and enjoying coffee.',
    },
    {
      'name': 'Kigali Central Police',
      'address': 'KN 3 Rd, Kigali',
      'phone': '+250 788 123 004',
      'rating': 4.2,
      'category': 'Police Station',
      'description':
          'Central police headquarters for public safety and assistance.',
    },
    {
      'name': 'Repub Lounge',
      'address': 'KG 674 St, Kigali',
      'phone': '+250 788 123 005',
      'rating': 4.6,
      'category': 'Restaurant',
      'description': 'Famous for its brochettes and vibrant atmosphere.',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize data in the Cubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<DirectoryCubit>().setPlaces(_mockData);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectoryCubit, DirectoryState>(
      builder: (context, state) {
        final filteredList = state.filteredPlaces;

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
                      _buildFilterSection(context, state),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selectedCategory == 'All'
                                ? 'All Places'
                                : '${state.selectedCategory} Listings',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${filteredList.length} places',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (filteredList.isEmpty)
                        _buildEmptyState()
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final place = filteredList[index];
                            return PlaceCard(
                              name: place['name'],
                              address: place['address'],
                              phone: place['phone'],
                              rating: place['rating'],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
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
            Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No places found',
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            ),
          ],
        ),
      ),
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
          const Text(
            'Kigali Directory',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Discover services and places',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) =>
                  context.read<DirectoryCubit>().updateSearchQuery(value),
              decoration: const InputDecoration(
                hintText: 'Search places by name...',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.black38, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, DirectoryState state) {
    final categories = [
      'All',
      'Hospital',
      'Restaurant',
      'Café',
      'Police Station',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.filter_list, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              'Filter by Category',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 20),
              ...categories.map((category) {
                return CategoryFilterChip(
                  label: category,
                  count: state.getCountForCategory(category),
                  isSelected: state.selectedCategory == category,
                  onTap: () =>
                      context.read<DirectoryCubit>().selectCategory(category),
                );
              }),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
