import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class FootprintDatePlanSlidableAction extends StatefulWidget {

  final Function(BuildContext) onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final String label;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final double offset1;
  final double offset2;
  // 완료 버튼쪽 margin 설정
  final double margin1;
  // 삭제 버튼쪽 margin 설정
  final double margin2;

  FootprintDatePlanSlidableAction({
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.label,
    required this.textStyle,
    this.borderRadius = BorderRadius.zero,
    this.offset1 = 0.0,
    this.offset2 = 0.0,
    this.margin1 = 0.0,
    this.margin2 = 0.0,
    super.key
  });

  @override
  State<FootprintDatePlanSlidableAction> createState() => _FootprintDatePlanSlidableActionState();
}

// SlidableAction 커스텀
class _FootprintDatePlanSlidableActionState extends State<FootprintDatePlanSlidableAction> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressed(context),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.252,
        margin: EdgeInsets.fromLTRB(widget.margin1, 0, widget.margin2, 0),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 3,
              // 그림자 위치 설정
              offset: Offset(widget.offset1, widget.offset2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.label, style: widget.textStyle),
          ],
        ),
      ),
    );
  }
}
