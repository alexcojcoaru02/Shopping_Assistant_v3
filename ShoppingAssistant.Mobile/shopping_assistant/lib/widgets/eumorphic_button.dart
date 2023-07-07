import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isFavorite;

  const NeumorphicButton({
    Key? key,
    required this.onPressed,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: _isHovered ? Colors.grey[200] : const Color(0xfff0f1f5),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                offset: const Offset(8, 8),
                blurRadius: 8,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-8, -8),
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
    );
  }
}
