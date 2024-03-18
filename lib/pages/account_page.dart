import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';

class AccountDashboard extends StatefulWidget {
  @override
  _AccountDashboardState createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  File? _image;
  bool _isLoading = false;
  final picker = ImagePicker();
  String? _selectedOption;
  Map<String, bool> _optionsEnabled = {
    'Add Contact': true,
    'Edit Contact': true,
    'Remove Contact': true,
    'Emergency Alerts': true,
    'Location Sharing': true,
    'Sound & Vibration': true,
    'Health Profile': true,
    'Medical ID': true,
    'Location Accuracy': true,
    'Location Sharing Permissions': true,
  };

  String _userName = 'Theodore B.';
  String _userEmail = 'theodore@example.com';

  Future<void> getImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildSettingsCard({
    required IconData icon,
    required String title,
    required List<String> options,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _selectedOption = _selectedOption == title ? null : title;
              });
            },
            leading: Icon(icon),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (_selectedOption == title)
            Column(
              children: options.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: title == 'Notification Settings'
                      ? Switch(
                          value: _optionsEnabled[option] ?? false,
                          onChanged: (bool value) {
                            setState(() {
                              _optionsEnabled[option] = value;
                            });
                          },
                        )
                      : null,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () => _showImagePickerDialog(),
                child: Stack(
                  children: [
                    _image == null
                        ? CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.account_circle,
                              size: 120,
                              color: Colors.grey,
                            ),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(_image!),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showImagePickerDialog(),
                      ),
                    ),
                    if (_isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    _userName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    _userEmail,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSettingsCard(
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    options: [
                      'Edit Number',
                      'Edit Address',
                      'Edit Email',
                    ],
                  ),
                  buildSettingsCard(
                    icon: Icons.contacts,
                    title: 'Emergency Contacts',
                    options: [
                      'Add Contact',
                      'Edit Contact',
                      'Remove Contact',
                    ],
                  ),
                  buildSettingsCard(
                    icon: Icons.notifications,
                    title: 'Notification Settings',
                    options: [
                      'Emergency Alerts',
                      'Location Sharing',
                      'Sound & Vibration',
                    ],
                  ),
                  buildSettingsCard(
                    icon: Icons.medical_services,
                    title: 'Medical Information',
                    options: [
                      'Health Profile',
                      'Medical ID',
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _showLogoutConfirmationDialog(),
                    icon: Icon(Icons.logout),
                    label: Text('Log Out'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                // Add an option to delete profile picture
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove Profile Picture'),
                  onTap: () {
                    setState(() {
                      _image = null;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLogoutConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}
