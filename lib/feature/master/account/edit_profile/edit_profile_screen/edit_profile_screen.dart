import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/account/account_shared/account_shared.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({required this.initialProfile, super.key});

  final AccountProfileData initialProfile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _memberSinceController;
  late String _imageUrl;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialProfile.name);
    _emailController = TextEditingController(text: widget.initialProfile.email);
    _phoneController = TextEditingController(text: widget.initialProfile.phone);
    _memberSinceController = TextEditingController(
      text: widget.initialProfile.memberSince,
    );
    _imageUrl = widget.initialProfile.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _memberSinceController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (pickedFile == null || !mounted) {
        return;
      }

      setState(() {
        _imageUrl = pickedFile.path;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to update profile photo right now.'),
        ),
      );
    }
  }

  void _changePhoto() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Change Photo', style: AppTextStyle.heading),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColor.primary,
                  ),
                  title: const Text('Take Photo'),
                  subtitle: const Text('Use your camera to capture a profile photo.'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickPhoto(ImageSource.camera);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: AppColor.primary,
                  ),
                  title: const Text('Choose From Gallery'),
                  subtitle: const Text('Pick a photo from your gallery.'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickPhoto(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveProfile() {
    Navigator.pop<AccountProfileData>(
      context,
      AccountProfileData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        memberSince: _memberSinceController.text.trim(),
        imageUrl: _imageUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Edit Profile'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 46,
                  backgroundImage: accountProfileImageProvider(_imageUrl),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _changePhoto,
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('Change Photo'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          AccountInfoCard(
            title: 'Profile Details',
            children: <Widget>[
              AccountEditableField(
                label: 'Full name',
                controller: _nameController,
              ),
              AccountEditableField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              AccountEditableField(
                label: 'Phone',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              AccountEditableField(
                label: 'Member since',
                controller: _memberSinceController,
              ),
            ],
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _saveProfile,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
