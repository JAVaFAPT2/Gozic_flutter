import 'package:flutter/material.dart';

class GzButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expanded;
  final bool disabled;

  const GzButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expanded = true,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        minimumSize: const Size(140, 48),
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(label),
    );
    return expanded ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
