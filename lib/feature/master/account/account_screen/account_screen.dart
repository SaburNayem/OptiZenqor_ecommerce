import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/account/account_controller/account_controller.dart';
import 'package:optizenqor/feature/master/account/account_model/account_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/http_mathod/network_service/catalog_service.dart';

ImageProvider<Object> _profileImageProvider(String imagePath) {
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return NetworkImage(imagePath);
  }

  return FileImage(File(imagePath));
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _handleAction(BuildContext context, AccountActionModel action) {
    switch (action.title) {
      case 'Personal Details':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const _PersonalDetailsScreen(),
          ),
        );
        return;
      case 'My Order':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const _MyOrdersScreen(),
          ),
        );
        return;
      case 'Delivery Address':
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const _DeliveryAddressScreen(),
          ),
        );
        return;
      case 'Order History':
        Navigator.pushNamed(
          context,
          AppRoute.drawerPage,
          arguments: 'Order History',
        );
        return;
      default:
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                _AccountActionDetailsScreen(action: action),
          ),
        );
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AccountModel data = AccountController().data;

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Account'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColor.border),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primary, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=12',
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data.name, style: AppTextStyle.title),
                    const SizedBox(height: 4),
                    Text(data.email, style: AppTextStyle.body),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...data.actions.map(
            (AccountActionModel action) => InkWell(
              onTap: () => _handleAction(context, action),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColor.border),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0x1420B2AA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(action.icon, color: AppColor.primary),
                  ),
                  title: Text(action.title),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(action.subtitle, style: AppTextStyle.body),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalDetailsScreen extends StatefulWidget {
  const _PersonalDetailsScreen();

  @override
  State<_PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<_PersonalDetailsScreen> {
  _ProfileData _profile = const _ProfileData(
    name: 'Shob Bazaar',
    email: 'support@yourapp.com',
    phone: '+880 1700 000000',
    memberSince: 'March 2025',
    imageUrl: 'https://i.pravatar.cc/200?img=12',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Personal Details'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 46,
                  backgroundImage: _profileImageProvider(_profile.imageUrl),
                ),
                const SizedBox(height: 12),
                const Text('Profile Photo', style: AppTextStyle.title),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _InfoCard(
            title: 'Profile',
            children: <Widget>[
              _LabeledRow(label: 'Full name', value: _profile.name),
              _LabeledRow(label: 'Email', value: _profile.email),
              _LabeledRow(label: 'Phone', value: _profile.phone),
              _LabeledRow(label: 'Member since', value: _profile.memberSince),
            ],
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: _openEditProfile,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Future<void> _openEditProfile() async {
    final bool? canEdit = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: const Text(
            'Do you want to allow editing your profile details and photo?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Allow'),
            ),
          ],
        );
      },
    );

    if (canEdit != true || !mounted) {
      return;
    }

    final _ProfileData? updatedProfile = await Navigator.push<_ProfileData>(
      context,
      MaterialPageRoute<_ProfileData>(
        builder: (BuildContext context) =>
            _EditProfileScreen(initialProfile: _profile),
      ),
    );

    if (updatedProfile == null || !mounted) {
      return;
    }

    setState(() {
      _profile = updatedProfile;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Personal details updated successfully.')),
    );
  }
}

class _EditProfileScreen extends StatefulWidget {
  const _EditProfileScreen({required this.initialProfile});

  final _ProfileData initialProfile;

  @override
  State<_EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<_EditProfileScreen> {
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
    Navigator.pop<_ProfileData>(
      context,
      _ProfileData(
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
                  backgroundImage: _profileImageProvider(_imageUrl),
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
          _InfoCard(
            title: 'Profile Details',
            children: <Widget>[
              _EditableField(
                label: 'Full name',
                controller: _nameController,
              ),
              _EditableField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              _EditableField(
                label: 'Phone',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              _EditableField(
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

class _DeliveryAddressScreen extends StatefulWidget {
  const _DeliveryAddressScreen();

  @override
  State<_DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<_DeliveryAddressScreen> {
  late final TextEditingController _labelController;
  late final TextEditingController _addressController;
  late final TextEditingController _noteController;
  String _selectedLabel = 'Home';

  final List<Map<String, String>> _savedAddresses = <Map<String, String>>[
    <String, String>{
      'label': 'Home',
      'address': 'House 12, Road 5, Mirpur 1, Dhaka',
      'note': 'Primary delivery address',
    },
    <String, String>{
      'label': 'Office',
      'address': 'Level 8, Banani DOHS, Dhaka',
      'note': 'Available on weekdays, 10 AM - 6 PM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: 'Home');
    _addressController = TextEditingController(
      text: 'House 12, Road 5, Mirpur 1, Dhaka',
    );
    _noteController = TextEditingController(text: 'Primary delivery address');
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _loadAddress(Map<String, String> address) {
    setState(() {
      _selectedLabel = address['label'] ?? 'Home';
      _labelController.text = address['label'] ?? '';
      _addressController.text = address['address'] ?? '';
      _noteController.text = address['note'] ?? '';
    });
  }

  void _pickMapLocation() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        final List<Map<String, String>> locations = <Map<String, String>>[
          <String, String>{
            'label': 'Home',
            'address': 'House 12, Road 5, Mirpur 1, Dhaka',
            'note': 'Primary delivery address',
          },
          <String, String>{
            'label': 'Office',
            'address': 'Level 8, Banani DOHS, Dhaka',
            'note': 'Available on weekdays, 10 AM - 6 PM',
          },
          <String, String>{
            'label': 'Parents',
            'address': 'Block C, Section 6, Uttara, Dhaka',
            'note': 'Weekend delivery preferred',
          },
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Pick From Map',
                  style: AppTextStyle.heading,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose a saved pin to update the delivery address.',
                  style: AppTextStyle.body,
                ),
                const SizedBox(height: 16),
                ...locations.map((Map<String, String> item) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.location_on,
                      color: AppColor.primary,
                    ),
                    title: Text(item['label'] ?? ''),
                    subtitle: Text(item['address'] ?? ''),
                    onTap: () {
                      Navigator.pop(context);
                      _loadAddress(item);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveAddress() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Delivery address updated successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Delivery Address'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          _InfoCard(
            title: 'Map Location',
            children: <Widget>[
              InkWell(
                onTap: _pickMapLocation,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFFD7F7F6),
                        Color(0xFFF5FFFE),
                      ],
                    ),
                    border: Border.all(color: AppColor.border),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 18,
                        top: 28,
                        right: 18,
                        child: Container(
                          height: 14,
                          decoration: BoxDecoration(
                            color: const Color(0x3320B2AA),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: 72,
                        child: Container(
                          width: 120,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0x3320B2AA),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 28,
                        top: 54,
                        child: Container(
                          width: 90,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0x3320B2AA),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 98,
                        top: 56,
                        child: Icon(
                          Icons.location_pin,
                          size: 42,
                          color: AppColor.primary,
                        ),
                      ),
                      const Positioned(
                        right: 56,
                        bottom: 34,
                        child: Icon(
                          Icons.location_pin,
                          size: 36,
                          color: Colors.redAccent,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.map_outlined,
                                color: AppColor.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _addressController.text,
                                  style: AppTextStyle.body,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Change',
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Saved Addresses',
            children: _savedAddresses.map((Map<String, String> item) {
              final bool isSelected = _selectedLabel == item['label'];
              return InkWell(
                onTap: () => _loadAddress(item),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.card : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected ? AppColor.primary : AppColor.border,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.place_outlined, color: AppColor.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item['label'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['address'] ?? '',
                              style: AppTextStyle.body,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Edit Address',
            children: <Widget>[
              _EditableField(
                label: 'Address label',
                controller: _labelController,
              ),
              _EditableField(
                label: 'Street address',
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
              ),
              _EditableField(
                label: 'Delivery note',
                controller: _noteController,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickMapLocation,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    side: const BorderSide(color: AppColor.primary),
                    foregroundColor: AppColor.primary,
                  ),
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('Use Map'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _saveAddress,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text('Save Address'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccountActionDetailsScreen extends StatelessWidget {
  const _AccountActionDetailsScreen({required this.action});

  final AccountActionModel action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(title: action.title),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: _buildSections(context),
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context) {
    switch (action.title) {
      case 'Personal Details':
        return <Widget>[
          const Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 46,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/200?img=12',
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Profile Photo',
                  style: AppTextStyle.title,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _InfoCard(
            title: 'Profile',
            children: const <Widget>[
              _LabeledRow(label: 'Full name', value: 'Shob Bazaar'),
              _LabeledRow(label: 'Email', value: 'support@yourapp.com'),
              _LabeledRow(label: 'Phone', value: '+880 1700 000000'),
              _LabeledRow(label: 'Member since', value: 'March 2025'),
            ],
          ),
        ];
      case 'Settings':
        return <Widget>[
          _InfoCard(
            title: 'Notifications',
            children: const <Widget>[
              _SwitchRow(
                title: 'Push notifications',
                subtitle: 'Get updates on offers, orders and delivery progress.',
                value: true,
              ),
              _SwitchRow(
                title: 'Email updates',
                subtitle: 'Receive receipts and product suggestions by email.',
                value: true,
              ),
              _SwitchRow(
                title: 'SMS alerts',
                subtitle: 'Get courier and delivery updates by text message.',
                value: false,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Privacy',
            children: const <Widget>[
              _SwitchRow(
                title: 'Private profile',
                subtitle: 'Hide your review activity from other shoppers.',
                value: false,
              ),
              _SwitchRow(
                title: 'Biometric login',
                subtitle: 'Use face or fingerprint login on supported devices.',
                value: true,
              ),
              _SwitchRow(
                title: 'Save payment information',
                subtitle: 'Speed up checkout with securely saved payment data.',
                value: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Language',
            children: const <Widget>[
              _ActionRow(
                icon: Icons.language_outlined,
                title: 'App language',
                subtitle: 'English (US)',
              ),
              _ActionRow(
                icon: Icons.translate_outlined,
                title: 'Product translation',
                subtitle: 'Show product details in your preferred language.',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Shopping Preferences',
            children: <Widget>[
              _ActionRow(
                icon: Icons.payments_outlined,
                title: 'Currency',
                subtitle: 'USD',
              ),
              _ActionRow(
                icon: Icons.local_shipping_outlined,
                title: 'Delivery preference',
                subtitle: 'Home delivery prioritized',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Account Security',
            children: <Widget>[
              _ActionRow(
                icon: Icons.lock_reset_outlined,
                title: 'Reset password',
                subtitle: 'Open the password reset flow for your account.',
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.forgotPassword);
                },
              ),
              const _ActionRow(
                icon: Icons.verified_user_outlined,
                title: 'Two-step verification',
                subtitle: 'Extra protection for sign in and sensitive changes.',
              ),
              const _ActionRow(
                icon: Icons.devices_outlined,
                title: 'Manage devices',
                subtitle: 'See where your account is logged in.',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'App Controls',
            children: const <Widget>[
              _ActionRow(
                icon: Icons.cleaning_services_outlined,
                title: 'Clear search history',
                subtitle: 'Remove recent product and category searches.',
              ),
              _ActionRow(
                icon: Icons.download_done_outlined,
                title: 'Download settings',
                subtitle: 'Choose how images and offers are cached offline.',
              ),
              _ActionRow(
                icon: Icons.info_outline,
                title: 'App version',
                subtitle: 'OptiZenqor 1.0.0',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Policy',
            children: const <Widget>[
              _ActionRow(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy policy',
                subtitle: 'Learn how your account and order data is handled.',
              ),
              _ActionRow(
                icon: Icons.assignment_outlined,
                title: 'Terms and conditions',
                subtitle: 'Read the shopping and service policies for the app.',
              ),
              _ActionRow(
                icon: Icons.local_shipping_outlined,
                title: 'Return policy',
                subtitle: 'See return windows, refund terms and support rules.',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Support',
            children: <Widget>[
              _ActionRow(
                icon: Icons.help_outline,
                title: 'Help center',
                subtitle: 'Browse common account and shopping questions.',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.drawerPage,
                    arguments: 'Help',
                  );
                },
              ),
              _ActionRow(
                icon: Icons.support_agent_outlined,
                title: 'Contact support',
                subtitle: 'Reach our team for account or order assistance.',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.drawerPage,
                    arguments: 'Support',
                  );
                },
              ),
              _ActionRow(
                icon: Icons.reviews_outlined,
                title: 'App review',
                subtitle: 'Share feedback and rate your shopping experience.',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.drawerPage,
                    arguments: 'Review',
                  );
                },
              ),
            ],
          ),
        ];
      case 'Payment Method':
        return <Widget>[
          _InfoCard(
            title: 'Saved Cards',
            children: const <Widget>[
              _PaymentCardTile(
                title: 'Visa ending in 2048',
                subtitle: 'Default payment method',
                color: Color(0xFF0D47A1),
              ),
              _PaymentCardTile(
                title: 'Mastercard ending in 8891',
                subtitle: 'Expires 11/28',
                color: Color(0xFF00695C),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            title: 'Billing',
            children: <Widget>[
              _LabeledRow(label: 'Billing name', value: 'Shob Bazaar'),
              _LabeledRow(label: 'Billing email', value: 'support@yourapp.com'),
              _LabeledRow(label: 'Currency', value: 'USD'),
            ],
          ),
        ];
      case 'Delivery Address':
        return <Widget>[
          _InfoCard(
            title: 'Saved Addresses',
            children: const <Widget>[
              _AddressTile(
                label: 'Home',
                address: 'House 12, Road 5, Mirpur 1, Dhaka',
                note: 'Primary delivery address',
              ),
              _AddressTile(
                label: 'Office',
                address: 'Level 8, Banani DOHS, Dhaka',
                note: 'Available on weekdays, 10 AM - 6 PM',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Address Actions',
            children: <Widget>[
              _ActionRow(
                icon: Icons.add_location_alt_outlined,
                title: 'Add new address',
                subtitle: 'Create another delivery location for faster checkout.',
              ),
            ],
          ),
        ];
      case 'Pickup Point':
        return <Widget>[
          const _InfoCard(
            title: 'Available Pickup Points',
            children: <Widget>[
              _AddressTile(
                label: 'Mirpur Hub',
                address: 'Road 10, Mirpur 1, Dhaka',
                note: 'Open daily from 9 AM - 9 PM',
              ),
              _AddressTile(
                label: 'Banani Point',
                address: 'Block C, Banani, Dhaka',
                note: 'Fast pickup for small and medium parcels',
              ),
              _AddressTile(
                label: 'Uttara Collection Center',
                address: 'Sector 7, Uttara, Dhaka',
                note: 'Weekend pickup available',
              ),
            ],
          ),
        ];
      default:
        return <Widget>[
          _InfoCard(
            title: action.title,
            children: <Widget>[
              Text(
                action.subtitle,
                style: AppTextStyle.body,
              ),
            ],
          ),
        ];
    }
  }
}

class _MyOrdersScreen extends StatefulWidget {
  const _MyOrdersScreen();

  @override
  State<_MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<_MyOrdersScreen> {
  static const List<String> _statuses = <String>[
    'To Pay',
    'To Ship',
    'To Receive',
    'To Review',
    'To Return',
    'Cancellation',
  ];

  late final List<_MyOrderItem> _orders;
  String _selectedStatus = _statuses.first;

  @override
  void initState() {
    super.initState();
    final List<ProductModel> products = const CatalogService().getProducts();
    _orders = <_MyOrderItem>[
      _MyOrderItem(
        id: 'mo-1',
        product: products[1],
        status: 'To Pay',
        date: 'March 20, 2026',
        amount: '\$${products[1].price.toStringAsFixed(2)}',
        actionLabel: 'Pay Now',
      ),
      _MyOrderItem(
        id: 'mo-2',
        product: products[3],
        status: 'To Ship',
        date: 'March 18, 2026',
        amount: '\$${products[3].price.toStringAsFixed(2)}',
        actionLabel: 'Track Packing',
      ),
      _MyOrderItem(
        id: 'mo-3',
        product: products[4],
        status: 'To Receive',
        date: 'March 17, 2026',
        amount: '\$${products[4].price.toStringAsFixed(2)}',
        actionLabel: 'Track Delivery',
      ),
      _MyOrderItem(
        id: 'mo-4',
        product: products[6],
        status: 'To Review',
        date: 'March 14, 2026',
        amount: '\$${products[6].price.toStringAsFixed(2)}',
        actionLabel: 'Write Review',
      ),
      _MyOrderItem(
        id: 'mo-5',
        product: products[5],
        status: 'To Return',
        date: 'March 10, 2026',
        amount: '\$${products[5].price.toStringAsFixed(2)}',
        actionLabel: 'Request Return',
      ),
      _MyOrderItem(
        id: 'mo-6',
        product: products[0],
        status: 'Cancellation',
        date: 'March 9, 2026',
        amount: '\$${products[0].price.toStringAsFixed(2)}',
        actionLabel: 'View Details',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<_MyOrderItem> filteredOrders = _orders
        .where((_MyOrderItem order) => order.status == _selectedStatus)
        .toList();

    return Scaffold(
      appBar: const AppCustomAppBar(title: 'My Order'),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 66,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              scrollDirection: Axis.horizontal,
              itemCount: _statuses.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 10),
              itemBuilder: (BuildContext context, int index) {
                final String status = _statuses[index];
                final bool isSelected = status == _selectedStatus;
                return ChoiceChip(
                  label: Text(status),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedStatus = status;
                    });
                  },
                  selectedColor: AppColor.primary,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColor.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  side: const BorderSide(color: AppColor.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'No orders available in $_selectedStatus.',
                        style: AppTextStyle.body,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    itemCount: filteredOrders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _MyOrderItem order = filteredOrders[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColor.border),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.productDetails,
                              arguments: order.product,
                            );
                          },
                          borderRadius: BorderRadius.circular(22),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      order.status,
                                      style: const TextStyle(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      order.date,
                                      style: AppTextStyle.body.copyWith(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        order.product.imageUrl,
                                        width: 86,
                                        height: 86,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            order.product.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            order.product.categoryName,
                                            style: AppTextStyle.body.copyWith(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            order.amount,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Order ID: ${order.id}',
                                      style: AppTextStyle.body.copyWith(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.productDetails,
                                          arguments: order.product,
                                        );
                                      },
                                      child: Text(order.actionLabel),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: AppTextStyle.title),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _LabeledRow extends StatelessWidget {
  const _LabeledRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.body.copyWith(color: Colors.black54),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  const _EditableField({
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: AppTextStyle.body.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0x1420B2AA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColor.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyle.body),
                ],
              ),
            ),
            if (onTap != null)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(Icons.chevron_right),
              ),
          ],
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
  });

  final String title;
  final String subtitle;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyle.body),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IgnorePointer(
            child: Switch(
              value: value,
              onChanged: (_) {},
              activeThumbColor: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentCardTile extends StatelessWidget {
  const _PaymentCardTile({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.credit_card, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({
    required this.label,
    required this.address,
    required this.note,
  });

  final String label;
  final String address;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.place_outlined, color: AppColor.primary),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Text(address, style: AppTextStyle.body),
          const SizedBox(height: 6),
          Text(
            note,
            style: AppTextStyle.body.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _MyOrderItem {
  const _MyOrderItem({
    required this.id,
    required this.product,
    required this.status,
    required this.date,
    required this.amount,
    required this.actionLabel,
  });

  final String id;
  final ProductModel product;
  final String status;
  final String date;
  final String amount;
  final String actionLabel;
}

class _ProfileData {
  const _ProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.memberSince,
    required this.imageUrl,
  });

  final String name;
  final String email;
  final String phone;
  final String memberSince;
  final String imageUrl;
}
