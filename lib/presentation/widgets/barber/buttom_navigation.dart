import 'package:flutter/material.dart';

class ButtomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const ButtomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home, "Home", 0),
            _buildNavItem(context, Icons.add, "availability", 1),

            _buildNavItem(context, Icons.calendar_today, "Bookings", 2),
            _buildNavItem(context, Icons.person, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.orange : Colors.black),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
