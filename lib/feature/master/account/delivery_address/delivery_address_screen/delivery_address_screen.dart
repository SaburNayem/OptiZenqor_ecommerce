import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/custom_appbar.dart';
import 'package:optizenqor/feature/master/account/account_shared/account_shared.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
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
                const Text('Pick From Map', style: AppTextStyle.heading),
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
          AccountInfoCard(
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
          AccountInfoCard(
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
          AccountInfoCard(
            title: 'Edit Address',
            children: <Widget>[
              AccountEditableField(
                label: 'Address label',
                controller: _labelController,
              ),
              AccountEditableField(
                label: 'Street address',
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
              ),
              AccountEditableField(
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
