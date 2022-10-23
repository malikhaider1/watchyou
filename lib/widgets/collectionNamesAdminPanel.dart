import 'package:flutter/material.dart';

import '../screens/LoginPage.dart';

class collectionNames extends StatelessWidget {
  const collectionNames({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('anime')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('action')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('trending')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('comedies')),
              selected: true,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(
                  child: Text('familywatch')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('newrelease')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('scifi')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('horror')),
              selected: true,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(
                  child: Text('suspensefull')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('romance')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('reallife')),
              selected: true,
            ),
            ChoiceChip(
              selectedColor: primaryColor,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('addtodiary')),
              selected: true,
            ),
          ],
        )
      ],
    );
  }
}