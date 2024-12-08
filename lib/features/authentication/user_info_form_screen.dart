// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:kfupm_sports/providers/player_provider.dart';
import 'package:provider/provider.dart';

class UserInfoFormScreen extends StatefulWidget {
  const UserInfoFormScreen({super.key});

  @override
  _UserInfoFormScreenState createState() => _UserInfoFormScreenState();
}

class _UserInfoFormScreenState extends State<UserInfoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  // File? _profilePicture;
  final _fullNameController = TextEditingController();
  final _bioController = TextEditingController();

  final List<String> sportsList = [
    'Football',
    'Volleyball',
    'Basketball',
    'Tennis',
  ];
  final List<String> positionsList = [
    'Football - Forward',
    'Football - Midfielder',
    'Football - Defender',
    'Football - Goalkeeper',
    'Volleyball - Setter',
    'Volleyball - Hitter',
    'Volleyball - Defender',
    'Volleyball - Libero',
    'Basketball - Forward',
    'Basketball - Midfielder',
    'Basketball - Defender',
    'Basketball - Guard',
  ];
  List<String> selectedSports = [];
  List<String> selectedPositions = [];

  // Future<void> _pickProfilePicture() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _profilePicture = File(pickedFile.path);
  //     });
  //   }
  // }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Save data to Firebase or any backend
      final userData = {
        'name': _fullNameController.text.trim(),
        'bio': _bioController.text.trim(),
        'favoriteSports': selectedSports,
        'preferredPositions': selectedPositions,
      };

      // Accessing PlayerProvider safely
      final playerProvider =
          Provider.of<PlayerProvider>(context, listen: false);

      playerProvider.savePlayerData(userData).then((_) {
        // Navigate to the home screen after successful submission
        Navigator.pushReplacementNamed(context, '/home');
      }).catchError((error) {
        // Handle errors gracefully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save data: $error')),
        );
      });
      print(userData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // Profile Picture Picker
              // GestureDetector(
              //   onTap: _pickProfilePicture,
              //   child: CircleAvatar(
              //     radius: 50,
              //     backgroundImage: _profilePicture != null
              //         ? FileImage(_profilePicture!)
              //         : null,
              //     child: _profilePicture == null
              //         ? const Icon(Icons.camera_alt, size: 50)
              //         : null,
              //   ),
              // ),
              // const SizedBox(height: 20),

              // Full Name Field
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Bio Field
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Favorite Sports Field
              const Text('Favorite Sports'),
              Wrap(
                spacing: 10,
                children: sportsList.map((sport) {
                  return FilterChip(
                    label: Text(sport),
                    selected: selectedSports.contains(sport),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedSports.add(sport);
                        } else {
                          selectedSports.remove(sport);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Preferred Positions Field
              const Text('Preferred Positions'),
              Wrap(
                spacing: 10,
                children: positionsList.map((position) {
                  return FilterChip(
                    label: Text(position),
                    selected: selectedPositions.contains(position),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedPositions.add(position);
                        } else {
                          selectedPositions.remove(position);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Save Info'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
