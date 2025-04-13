import 'package:flutter/material.dart';
import 'package:car_connect/core/resource/color_manager.dart';
import 'package:car_connect/core/resource/size_manager.dart';

class ExpansionCard extends StatefulWidget {
  final Color color;
  final Widget headerWidget;
  final Widget expansionWidget;

  const ExpansionCard(
      {super.key,
        required this.color,
        required this.headerWidget,
        required this.expansionWidget});

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isExpanded = !isExpanded);
      },
      child: Container(
        padding: EdgeInsets.all(AppWidthManager.w3Point8),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(AppRadiusManager.r20),
        ),
        child: Column(
          children: [
            widget.headerWidget,

            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear,
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                  constraints: isExpanded
                      ? const BoxConstraints()
                      : const BoxConstraints(maxHeight: 0),
                  child: widget.expansionWidget),
            ),

            IconButton(
              splashColor: AppColorManager.transparent,
              onPressed: () {
                setState(() => isExpanded = !isExpanded);
              },
              icon: AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: AppWidthManager.w8,
                  color: AppColorManager.navy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
