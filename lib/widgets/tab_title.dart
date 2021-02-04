import 'package:flutter/material.dart';

class TabTitle extends StatelessWidget {
  const TabTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 32,
        ),
        Text(
          '$title',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
