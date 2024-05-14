import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../data/models/response/profile/profile_details.dart';
import '../../../../../utils/colors/colors.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileDetails profileDetails;

  const EditProfileScreen({Key? key, required this.profileDetails})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late ProfileDetails _profileDetails;

  final picker = ImagePicker();
  File _profileImage = File('');

  @override
  void initState() {
    super.initState();
    _profileDetails = widget.profileDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _editProfileAppBar(context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      _profileImage.path.isNotEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: FileImage(_profileImage),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(_profileDetails.profileImageUrl),
                            ),
                      Positioned(
                        top: 50,
                        left: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.photo),
                              onPressed: () {
                                openCameraGallery(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "First Name",
                TextEditingController(text: _profileDetails.firstName),
                "Enter your first name",
                TextInputType.text,
                [],
                (value) {
                  _profileDetails.firstName = value;
                },
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "Last Name",
                TextEditingController(text: _profileDetails.lastName),
                "Enter your last name",
                TextInputType.text,
                [],
                (value) {
                  _profileDetails.lastName = value;
                },
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "Instagram",
                TextEditingController(text: _profileDetails.instagram),
                "Enter your Instagram handle",
                TextInputType.text,
                [],
                (value) {
                  _profileDetails.instagram = value;
                },
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "TikTok",
                TextEditingController(text: _profileDetails.tikTok),
                "Enter your TikTok handle",
                TextInputType.text,
                [],
                (value) {
                  _profileDetails.tikTok = value;
                },
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "Facebook",
                TextEditingController(text: _profileDetails.facebook),
                "Enter your Facebook handle",
                TextInputType.text,
                [],
                (value) {
                  _profileDetails.facebook = value;
                },
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "LinkedIn",
                TextEditingController(text: _profileDetails.linkedIn),
                "Enter your LinkedIn handle",
                TextInputType.text,
                [],
                (value) {
                  _profileDetails.linkedIn = value;
                },
              ),
              const SizedBox(height: 8),
              _buildTextField(
                "Bio",
                TextEditingController(text: _profileDetails.bio),
                "Enter your bio",
                TextInputType.multiline,
                [],
                (value) {
                  _profileDetails.bio = value;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: SMColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(double.infinity, 40),
          ),
          child: const Text('Save Changes'),
          onPressed: () async {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hintText,
    TextInputType textInputType,
    List<TextInputFormatter> formatters,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14, color: SMColors.darkBlack.withOpacity(0.8)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: textInputType,
            inputFormatters: formatters,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.only(left: 24),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: SMColors.primaryColor),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openCameraGallery(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Define a method to open the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }
}

AppBar _editProfileAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    title: const Text('Edit Profile',
        style: TextStyle(color: SMColors.darkBlack)),
    leading: IconButton(
      icon: const IconTheme(
        data: IconThemeData(color: SMColors.darkBlack),
        child: BackButtonIcon(),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}
