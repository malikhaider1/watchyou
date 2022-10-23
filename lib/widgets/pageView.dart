import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:watchyou/assets/lists.dart';
import 'package:watchyou/screens/LoginPage.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: sizeHeight / (2.84),
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
          itemCount: AllLists().pageViewList.length,
          itemBuilder: (context, index, int) {
            return OnBoarding(index: index);
          },
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 0.5,
            height: sizeHeight / (3.04),
          )),
    );
  }
}

class OnBoarding extends StatelessWidget {
  AllLists allLists = AllLists();
  final int index;

  OnBoarding({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: sizeWidth / (2.1),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              blurRadius: 10,
              color: primaryColor.withOpacity(0.1),
            ),
          ],
          image: DecorationImage(
              image: AssetImage(
                allLists.pageViewList[index],
              ),
              fit: BoxFit.cover),
          shape: BoxShape.rectangle),
    );
  }
}