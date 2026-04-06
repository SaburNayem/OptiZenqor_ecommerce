import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/account/account_shared/account_shared.dart';
import 'package:optizenqor/feature/master/account/edit_profile/edit_profile_screen/edit_profile_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  AccountProfileData _profile = const AccountProfileData(
    name: 'Optizenqor Store',
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
                  backgroundImage: accountProfileImageProvider(_profile.imageUrl),
                ),
                const SizedBox(height: 12),
                const Text('Profile Photo', style: AppTextStyle.title),
              ],
            ),
          ),
          const SizedBox(height: 18),
          AccountInfoCard(
            title: 'Profile',
            children: <Widget>[
              AccountLabeledRow(label: 'Full name', value: _profile.name),
              AccountLabeledRow(label: 'Email', value: _profile.email),
              AccountLabeledRow(label: 'Phone', value: _profile.phone),
              AccountLabeledRow(label: 'Member since', value: _profile.memberSince),
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

    final AccountProfileData? updatedProfile =
        await Navigator.push<AccountProfileData>(
          context,
          MaterialPageRoute<AccountProfileData>(
            builder: (BuildContext context) =>
                EditProfileScreen(initialProfile: _profile),
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
