import 'package:flutter/material.dart';

import '../../../shared/widgets/gz_button.dart';
import 'new_user_profile.dart';

class InterestPickerPage extends StatefulWidget {
  final NewUserProfile profile;
  final VoidCallback onFinish;
  const InterestPickerPage({
    super.key,
    required this.profile,
    required this.onFinish,
  });

  @override
  State<InterestPickerPage> createState() => _InterestPickerPageState();
}

class _InterestPickerPageState extends State<InterestPickerPage> {
  final List<String> _options = [
    'Cây cảnh',
    'Xương rồng',
    'Thảo mộc',
    'Rau củ',
    'Hoa',
    'Cây ăn quả',
  ];

  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Text(
            'Chọn sở thích của bạn',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _options.map((e) {
              final selected = _selected.contains(e);
              return FilterChip(
                label: Text(e),
                selected: selected,
                onSelected: (s) => setState(() {
                  if (s) {
                    _selected.add(e);
                  } else {
                    _selected.remove(e);
                  }
                }),
              );
            }).toList(),
          ),
          const Spacer(),
          GzButton(
            label: 'Hoàn tất',
            onPressed: _selected.isNotEmpty
                ? () {
                    widget.profile.interests = _selected.toList();
                    widget.onFinish();
                  }
                : null,
            disabled: _selected.isEmpty,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
