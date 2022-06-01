import 'package:exams/utils/colors.dart';
import 'package:exams/utils/sizes.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

class OptionTile extends StatefulWidget {
  final bool answered;
  final String option;
  final String optionSelected;
  final String correctAnswer;
  final String mark;
  const OptionTile(
      {Key? key,
      required this.answered,
      required this.option,
      required this.optionSelected,
      required this.correctAnswer,
      required this.mark})
      : super(key: key);

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: widget.answered
              ? widget.option == widget.optionSelected
                  ? widget.option == widget.correctAnswer
                      ? Colors.green
                      : redColor
                  : circleAvatarColor
              : circleAvatarColor,
          child: Text(
            widget.mark,
            style: const TextStyle(color: whiteColor),
          ),
        ),
        gapW4,
        Text(widget.option)
      ],
    );
  }
}
