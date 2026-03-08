import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/models/place_model.dart';
import '../../logic/cubits/directory/directory_cubit.dart';
import '../../logic/cubits/directory/directory_state.dart';
import 'place_details_screen.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController? _mapController;

  // Kigali city center
  static const LatLng _kigaliCenter = LatLng(-1.9441, 30.0619);

  Set<Marker> _buildMarkers(List<Place> places) {
    final markers = <Marker>{};

    for (final place in places) {
      final lat = double.tryParse(place.latitude ?? '');
      final lng = double.tryParse(place.longitude ?? '');
      if (lat == null || lng == null) continue;

      markers.add(
        Marker(
          markerId: MarkerId(place.id),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlaceDetailsScreen(place: place),
                ),
              );
            },
          ),
        ),
      );
    }

    return markers;
  }

  void _fitAllMarkers(Set<Marker> markers) {
    if (markers.isEmpty || _mapController == null) return;

    if (markers.length == 1) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(markers.first.position, 15),
      );
      return;
    }

    double minLat = markers.first.position.latitude;
    double maxLat = markers.first.position.latitude;
    double minLng = markers.first.position.longitude;
    double maxLng = markers.first.position.longitude;

    for (final m in markers) {
      if (m.position.latitude < minLat) minLat = m.position.latitude;
      if (m.position.latitude > maxLat) maxLat = m.position.latitude;
      if (m.position.longitude < minLng) minLng = m.position.longitude;
      if (m.position.longitude > maxLng) maxLng = m.position.longitude;
    }

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        80,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectoryCubit, DirectoryState>(
      builder: (context, state) {
        final markers = _buildMarkers(state.allPlaces);
        final mappedCount = markers.length;
        final totalCount = state.allPlaces.length;

        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                  // Fit all markers after map is ready
                  Future.delayed(const Duration(milliseconds: 300), () {
                    _fitAllMarkers(markers);
                  });
                },
                initialCameraPosition: const CameraPosition(
                  target: _kigaliCenter,
                  zoom: 13,
                ),
                markers: markers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),

              // Top header card
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.map,
                        color: Color(0xFF1557F2),
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Kigali Map',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1557F2).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$mappedCount / $totalCount on map',
                          style: const TextStyle(
                            color: Color(0xFF1557F2),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom controls
              Positioned(
                bottom: 32,
                right: 16,
                child: Column(
                  children: [
                    // Fit all markers button
                    FloatingActionButton.small(
                      heroTag: 'fit_all',
                      backgroundColor: Colors.white,
                      tooltip: 'Show all places',
                      onPressed: () => _fitAllMarkers(markers),
                      child: const Icon(
                        Icons.fit_screen,
                        color: Color(0xFF1557F2),
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Re-center on Kigali
                    FloatingActionButton.small(
                      heroTag: 'center_kigali',
                      backgroundColor: const Color(0xFF1557F2),
                      tooltip: 'Center on Kigali',
                      onPressed: () {
                        _mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                            const CameraPosition(
                              target: _kigaliCenter,
                              zoom: 13,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              // No coordinates notice
              if (mappedCount < totalCount)
                Positioned(
                  bottom: 32,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 14,
                          color: Colors.orange[700],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${totalCount - mappedCount} place(s) missing coordinates',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
