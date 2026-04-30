import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isFullWidth;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: textColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMD,
          vertical: AppSizes.paddingMD,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AppSizes.paddingSM),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
