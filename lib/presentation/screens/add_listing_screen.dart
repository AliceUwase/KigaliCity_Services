import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/place_model.dart';
import '../../logic/cubits/directory/directory_cubit.dart';

class AddListingScreen extends StatefulWidget {
  final Place? place;

  const AddListingScreen({super.key, this.place});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _descriptionController;
  late TextEditingController _latController;
  late TextEditingController _lngController;

  bool get isEditMode => widget.place != null;

  final List<String> _categories = [
    'Hospital',
    'Restaurant',
    'Café',
    'Police Station',
    'School',
    'Bank',
    'Pharmacy',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.place?.name);
    _addressController = TextEditingController(text: widget.place?.address);
    _phoneController = TextEditingController(text: widget.place?.phone);
    _descriptionController = TextEditingController(
      text: widget.place?.description,
    );
    _latController = TextEditingController(text: widget.place?.latitude);
    _lngController = TextEditingController(text: widget.place?.longitude);
    _selectedCategory = widget.place?.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditMode ? 'Edit Listing' : 'Add New Listing',
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel('Place or Service Name *'),
                _buildTextField(
                  controller: _nameController,
                  hint: 'Enter name',
                ),
                const SizedBox(height: 20),
                _buildFieldLabel('Category *'),
                _buildCategoryDropdown(),
                const SizedBox(height: 20),
                _buildFieldLabel('Address *'),
                _buildTextField(
                  controller: _addressController,
                  hint: 'Enter address',
                ),
                const SizedBox(height: 20),
                _buildFieldLabel('Contact Number *'),
                _buildTextField(
                  controller: _phoneController,
                  hint: '+250 788 123 456',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                _buildFieldLabel('Description *'),
                _buildTextField(
                  controller: _descriptionController,
                  hint: 'Enter description',
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                _buildFieldLabel(
                  'Geographic Coordinates *',
                  icon: Icons.location_on_outlined,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _latController,
                        hint: 'Latitude',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _lngController,
                        hint: 'Longitude',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Example: Latitude: -1.9536, Longitude: 30.0927 (Kigali coordinates)',
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newPlace = Place(
                          id: isEditMode
                              ? widget.place!.id
                              : DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          name: _nameController.text,
                          address: _addressController.text,
                          phone: _phoneController.text,
                          category: _selectedCategory ?? 'Other',
                          description: _descriptionController.text,
                          latitude: _latController.text,
                          longitude: _lngController.text,
                          rating: widget.place?.rating ?? 0.0,
                        );

                        if (isEditMode) {
                          context.read<DirectoryCubit>().updatePlace(newPlace);
                        } else {
                          context.read<DirectoryCubit>().addPlace(newPlace);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEditMode
                                  ? 'Listing updated successfully!'
                                  : 'Listing created successfully!',
                            ),
                            backgroundColor: const Color(0xFF1557F2),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1557F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isEditMode ? Icons.update : Icons.save_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isEditMode ? 'Update Listing' : 'Create Listing',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedCategory,
        hint: const Text(
          'Select a category',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
        ),
        decoration: const InputDecoration(border: InputBorder.none),
        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
        items: _categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedCategory = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
      ),
    );
  }
}
