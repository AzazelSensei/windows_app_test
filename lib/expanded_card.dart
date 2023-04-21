import 'package:flutter/material.dart';

class ExpandedCard extends StatelessWidget {
  final BorderRadius radius;
  final Color color;
  final String title;
  final List<Widget> children;

  const ExpandedCard({
    super.key,
    required this.radius,
    required this.color,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        unselectedWidgetColor: Colors.black,
      ),
      child: ExpansionTile(
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide.none,
        ),
        collapsedBackgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide.none,
        ),
        tilePadding: const EdgeInsets.all(24),
        childrenPadding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        backgroundColor: color,
        expandedAlignment: Alignment.center,
        iconColor: Colors.black,
        title: Text(
          title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        children: children,
      ),
    );
  }
}
