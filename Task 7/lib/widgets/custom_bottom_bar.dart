import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        height: 64,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF131927) : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.grid_view_rounded, "Hub", primaryColor),
            _buildNavItem(1, Icons.location_on_rounded, "GPS", primaryColor),
            _buildNavItem(2, Icons.sensors_rounded, "Sensors", primaryColor),
            _buildNavItem(3, Icons.crop_free_rounded, "Level", primaryColor),
            _buildNavItem(4, Icons.qr_code_2_rounded, "QR", primaryColor),
            _buildNavItem(5, Icons.tune_rounded, "Settings", primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, Color primary) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? primary.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? primary : Colors.grey,
                size: 20,
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? primary : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
