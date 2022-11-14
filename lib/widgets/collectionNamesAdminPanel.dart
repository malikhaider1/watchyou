import 'package:flutter/material.dart';
import 'package:watchyou/screens/adminhomescreen.dart';

import '../screens/LoginPage.dart';

class CollectionNames extends StatelessWidget {
  const CollectionNames({
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
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text("anime")),
              onSelected: (index) {
                collectionNameController.text = "anime";
              },
              selected: true,
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('action')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "action";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('trending')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "trending";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('comedies')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "comedies";
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(
                  child: Text('familywatch')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "familywatch";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('newrelease')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "newrelease";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('scifi')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "scifi";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('horror')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "horror";
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(
                  child: Text('suspensefull')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "suspensefull";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label: const TextSelectionGestureDetector(child: Text('romance')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "romance";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('reallife')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "reallife";
              },
            ),
            ChoiceChip(
              selectedColor: Colors.white,
              shadowColor: primaryColor,
              elevation: 5,
              label:
                  const TextSelectionGestureDetector(child: Text('addtodiary')),
              selected: true,
              onSelected: (index) {
                collectionNameController.text = "addtodiary";
              },
            ),
          ],
        )
      ],
    );
  }
}
