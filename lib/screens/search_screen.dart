import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const path = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suche'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Card!'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
