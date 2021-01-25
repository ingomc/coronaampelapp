import 'package:flutter/material.dart';

class UpdateLine extends StatelessWidget {
  const UpdateLine({
    Key key,
    @required this.left,
    @required this.right,
  }) : super(key: key);

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.sync,
                color: Theme.of(context).hintColor,
                size: 16,
              ),
              Text(
                left,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          right,
          style: TextStyle(
            color: Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }
}
