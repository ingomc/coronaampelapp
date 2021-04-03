import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    if (right == '') {
      return Container();
    }
    return FadeIn(
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  MdiIcons.autorenew,
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
            '$right Uhr',
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
