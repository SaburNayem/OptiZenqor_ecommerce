import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/account/account_shared/account_shared.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailUpdates = true;
  bool _smsAlerts = false;
  bool _privateProfile = false;
  bool _biometricLogin = true;
  bool _savePaymentInformation = true;
  String _appLanguage = 'English (US)';
  String _productTranslation = 'English (US)';
  String _currency = 'USD';
  String _deliveryPreference = 'Home delivery prioritized';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          AccountInfoCard(
            title: 'Notifications',
            children: <Widget>[
              AccountSwitchRow(
                title: 'Push notifications',
                subtitle: 'Get updates on offers, orders and delivery progress.',
                value: _pushNotifications,
                onChanged: (bool value) =>
                    setState(() => _pushNotifications = value),
              ),
              AccountSwitchRow(
                title: 'Email updates',
                subtitle: 'Receive receipts and product suggestions by email.',
                value: _emailUpdates,
                onChanged: (bool value) =>
                    setState(() => _emailUpdates = value),
              ),
              AccountSwitchRow(
                title: 'SMS alerts',
                subtitle: 'Get courier and delivery updates by text message.',
                value: _smsAlerts,
                onChanged: (bool value) => setState(() => _smsAlerts = value),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountInfoCard(
            title: 'Privacy',
            children: <Widget>[
              AccountSwitchRow(
                title: 'Private profile',
                subtitle: 'Hide your review activity from other shoppers.',
                value: _privateProfile,
                onChanged: (bool value) =>
                    setState(() => _privateProfile = value),
              ),
              AccountSwitchRow(
                title: 'Biometric login',
                subtitle: 'Use face or fingerprint login on supported devices.',
                value: _biometricLogin,
                onChanged: (bool value) =>
                    setState(() => _biometricLogin = value),
              ),
              AccountSwitchRow(
                title: 'Save payment information',
                subtitle: 'Speed up checkout with securely saved payment data.',
                value: _savePaymentInformation,
                onChanged: (bool value) =>
                    setState(() => _savePaymentInformation = value),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountInfoCard(
            title: 'Language',
            children: <Widget>[
              AccountActionRow(
                icon: Icons.language_outlined,
                title: 'App language',
                subtitle: _appLanguage,
                onTap: () => _openSelectionScreen(
                  title: 'App language',
                  options: const <String>['English (US)', 'Bangla', 'Hindi'],
                  currentValue: _appLanguage,
                  onSelected: (String value) =>
                      setState(() => _appLanguage = value),
                ),
              ),
              AccountActionRow(
                icon: Icons.translate_outlined,
                title: 'Product translation',
                subtitle: _productTranslation,
                onTap: () => _openSelectionScreen(
                  title: 'Product translation',
                  options: const <String>[
                    'English (US)',
                    'Bangla',
                    'Auto detect',
                  ],
                  currentValue: _productTranslation,
                  onSelected: (String value) =>
                      setState(() => _productTranslation = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountInfoCard(
            title: 'Shopping Preferences',
            children: <Widget>[
              AccountActionRow(
                icon: Icons.payments_outlined,
                title: 'Currency',
                subtitle: _currency,
                onTap: () => _openSelectionScreen(
                  title: 'Currency',
                  options: const <String>['USD', 'BDT', 'EUR'],
                  currentValue: _currency,
                  onSelected: (String value) =>
                      setState(() => _currency = value),
                ),
              ),
              AccountActionRow(
                icon: Icons.local_shipping_outlined,
                title: 'Delivery preference',
                subtitle: _deliveryPreference,
                onTap: () => _openSelectionScreen(
                  title: 'Delivery preference',
                  options: const <String>[
                    'Home delivery prioritized',
                    'Pickup point prioritized',
                    'Fastest available option',
                  ],
                  currentValue: _deliveryPreference,
                  onSelected: (String value) =>
                      setState(() => _deliveryPreference = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountInfoCard(
            title: 'Account Security',
            children: <Widget>[
              AccountActionRow(
                icon: Icons.lock_reset_outlined,
                title: 'Reset password',
                subtitle: 'Open the reset password screen for your account.',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.resetPassword,
                    arguments: <String, dynamic>{'fromAccount': true},
                  );
                },
              ),
              AccountActionRow(
                icon: Icons.verified_user_outlined,
                title: 'Two-step verification',
                subtitle: 'Extra protection for sign in and sensitive changes.',
                onTap: () => _openDetailsScreen(
                  title: 'Two-step verification',
                  subtitle:
                      'Extra protection for sign in and sensitive changes.',
                  sections: const <_DetailSectionData>[
                    _DetailSectionData(
                      heading: 'Status',
                      body:
                          'Two-step verification can be managed from this dedicated security page.',
                    ),
                    _DetailSectionData(
                      heading: 'Protection',
                      body:
                          'This flow adds another confirmation step before sign-in and sensitive account changes.',
                    ),
                  ],
                ),
              ),
              AccountActionRow(
                icon: Icons.devices_outlined,
                title: 'Manage devices',
                subtitle: 'See where your account is logged in.',
                onTap: () => _openDetailsScreen(
                  title: 'Manage devices',
                  subtitle: 'See where your account is logged in.',
                  sections: const <_DetailSectionData>[
                    _DetailSectionData(
                      heading: 'Active sessions',
                      body:
                          'This screen is ready for device lists, sign-out controls, and login history.',
                    ),
                    _DetailSectionData(
                      heading: 'Next step',
                      body:
                          'Connect it to backend session data to show the user where their account is active.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountInfoCard(
            title: 'App Controls',
            children: <Widget>[
              AccountActionRow(
                icon: Icons.cleaning_services_outlined,
                title: 'Clear search history',
                subtitle: 'Remove recent product and category searches.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const _SearchHistoryScreen(),
                    ),
                  );
                },
              ),
              AccountActionRow(
                icon: Icons.download_done_outlined,
                title: 'Download settings',
                subtitle: 'Choose how images and offers are cached offline.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const _DownloadSettingsScreen(),
                    ),
                  );
                },
              ),
              AccountActionRow(
                icon: Icons.info_outline,
                title: 'App version',
                subtitle: 'OptiZenqor 1.0.0',
                onTap: () => _openDetailsScreen(
                  title: 'App version',
                  subtitle: 'OptiZenqor 1.0.0',
                  sections: const <_DetailSectionData>[
                    _DetailSectionData(
                      heading: 'Version',
                      body: 'You are using OptiZenqor version 1.0.0.',
                    ),
                    _DetailSectionData(
                      heading: 'Release details',
                      body:
                          'This page can show release notes, build number, and update availability.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountInfoCard(
            title: 'Policy',
            children: <Widget>[
              AccountActionRow(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy policy',
                subtitle: 'Learn how your account and order data is handled.',
                onTap: () => _openDetailsScreen(
                  title: 'Privacy policy',
                  subtitle:
                      'Learn how your account and order data is handled.',
                  sections: const <_DetailSectionData>[
                    _DetailSectionData(
                      heading: 'Data usage',
                      body:
                          'Your profile, order, and delivery data are used to support shopping, payments, and customer care.',
                    ),
                    _DetailSectionData(
                      heading: 'Privacy controls',
                      body:
                          'This page can later include consent, retention, and account data access details.',
                    ),
                  ],
                ),
              ),
              AccountActionRow(
                icon: Icons.assignment_outlined,
                title: 'Terms and conditions',
                subtitle: 'Read the shopping and service policies for the app.',
                onTap: () => _openDetailsScreen(
                  title: 'Terms and conditions',
                  subtitle:
                      'Read the shopping and service policies for the app.',
                  sections: const <_DetailSectionData>[
                    _DetailSectionData(
                      heading: 'Service terms',
                      body:
                          'Orders, payments, delivery, and returns are subject to app service terms and merchant availability.',
                    ),
                    _DetailSectionData(
                      heading: 'Usage rules',
                      body:
                          'This page can include customer responsibilities, merchant policies, and payment conditions.',
                    ),
                  ],
                ),
              ),
              AccountActionRow(
                icon: Icons.local_shipping_outlined,
                title: 'Return policy',
                subtitle: 'See return windows, refund terms and support rules.',
                onTap: () => _openDetailsScreen(
                  title: 'Return policy',
                  subtitle:
                      'See return windows, refund terms and support rules.',
                  sections: const <_DetailSectionData>[
                    _DetailSectionData(
                      heading: 'Eligibility',
                      body:
                          'Eligible products can be returned within the allowed window when they meet return conditions.',
                    ),
                    _DetailSectionData(
                      heading: 'Refund timeline',
                      body:
                          'This page can describe approval steps, pickups, replacements, and refund timing.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountInfoCard(
            title: 'Support',
            children: <Widget>[
              AccountActionRow(
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
              AccountActionRow(
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
              AccountActionRow(
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
        ],
      ),
    );
  }

  Future<void> _openSelectionScreen({
    required String title,
    required List<String> options,
    required String currentValue,
    required ValueChanged<String> onSelected,
  }) async {
    final String? selection = await Navigator.push<String>(
      context,
      MaterialPageRoute<String>(
        builder: (BuildContext context) => _SelectionOptionsScreen(
          title: title,
          currentValue: currentValue,
          options: options,
        ),
      ),
    );

    if (selection == null || !mounted) {
      return;
    }

    onSelected(selection);
  }

  void _openDetailsScreen({
    required String title,
    required String subtitle,
    required List<_DetailSectionData> sections,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => _InfoDetailsScreen(
          title: title,
          subtitle: subtitle,
          sections: sections,
        ),
      ),
    );
  }
}

class _SelectionOptionsScreen extends StatefulWidget {
  const _SelectionOptionsScreen({
    required this.title,
    required this.currentValue,
    required this.options,
  });

  final String title;
  final String currentValue;
  final List<String> options;

  @override
  State<_SelectionOptionsScreen> createState() =>
      _SelectionOptionsScreenState();
}

class _SelectionOptionsScreenState extends State<_SelectionOptionsScreen> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(title: widget.title),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          AccountInfoCard(
            title: 'Choose an option',
            children: widget.options
                .map(
                  (String option) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectedValue = option;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text(option)),
                          Icon(
                            option == _selectedValue
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: option == _selectedValue
                                ? AppColor.primary
                                : Colors.black45,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () => Navigator.pop(context, _selectedValue),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _InfoDetailsScreen extends StatelessWidget {
  const _InfoDetailsScreen({
    required this.title,
    required this.subtitle,
    required this.sections,
  });

  final String title;
  final String subtitle;
  final List<_DetailSectionData> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(title: title),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          AccountInfoCard(
            title: title,
            children: <Widget>[Text(subtitle, style: AppTextStyle.body)],
          ),
          const SizedBox(height: 16),
          ...sections.map(
            (_DetailSectionData section) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AccountInfoCard(
                title: section.heading,
                children: <Widget>[Text(section.body, style: AppTextStyle.body)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchHistoryScreen extends StatelessWidget {
  const _SearchHistoryScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Clear Search History'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const AccountInfoCard(
            title: 'Recent searches',
            children: <Widget>[
              AccountLabeledRow(label: '1', value: 'Laptop'),
              AccountLabeledRow(label: '2', value: 'Headphones'),
              AccountLabeledRow(label: '3', value: 'Smartphone'),
            ],
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text('Clear History'),
          ),
        ],
      ),
    );
  }
}

class _DownloadSettingsScreen extends StatefulWidget {
  const _DownloadSettingsScreen();

  @override
  State<_DownloadSettingsScreen> createState() =>
      _DownloadSettingsScreenState();
}

class _DownloadSettingsScreenState extends State<_DownloadSettingsScreen> {
  bool _wifiOnly = true;
  bool _cacheImages = true;
  bool _autoRefreshOffers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: 'Download Settings'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          AccountInfoCard(
            title: 'Offline preferences',
            children: <Widget>[
              AccountSwitchRow(
                title: 'Download on Wi-Fi only',
                subtitle: 'Avoid using mobile data for larger downloads.',
                value: _wifiOnly,
                onChanged: (bool value) {
                  setState(() {
                    _wifiOnly = value;
                  });
                },
              ),
              AccountSwitchRow(
                title: 'Cache product images',
                subtitle: 'Keep product thumbnails available offline.',
                value: _cacheImages,
                onChanged: (bool value) {
                  setState(() {
                    _cacheImages = value;
                  });
                },
              ),
              AccountSwitchRow(
                title: 'Auto refresh offers',
                subtitle: 'Update saved promotions when the device is online.',
                value: _autoRefreshOffers,
                onChanged: (bool value) {
                  setState(() {
                    _autoRefreshOffers = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailSectionData {
  const _DetailSectionData({
    required this.heading,
    required this.body,
  });

  final String heading;
  final String body;
}
